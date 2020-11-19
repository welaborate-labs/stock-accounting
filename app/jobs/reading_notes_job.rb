class ReadingNotesJob < ApplicationJob
  queue_as :default

  def perform(statement_file_id:)
    statement_file = StatementFile.find(statement_file_id)

    reader = PDF::Reader.new(statement_file.file.download)

    cnpj_or_cpf = nil

    reader.pages.each do |page|
      statement_number = page.text.match('\d{6}').to_s

      if previous_statement_number && previous_statement_number == statement_number
        statement.content << page.text
      else
        Statement.create(statement_date: date,
                          statement_file_id: statement_file.id,
                          brokerage_account_id: BrokerageAccount.last.id,
                          content: page.text)
      end

      previous_statement_number = statement_number
    end
    statement_file.update(processed_at: DateTime.now)
    
  end
end
