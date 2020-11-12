class ReadingNotesJob < ApplicationJob
  queue_as :default

  def perform(path, statement_file)
    io = open(path)
    reader = PDF::Reader.new(io)

    @cnpj_or_cpf = nil

    reader.pages.each do |page|
      note_number     = page.text.match('\d{6}').to_s
      date            = page.text.match('\d{1,2}\/\d{1,2}\/\d{4}').to_s
      client_number   = page.text.match('\d{7}\-?\d{1}').to_s
      cnpj            = page.text.match('\d{2}\.?\d{3}\.?\d{3}\/\d{4}\-?\d{2}').to_s
      cpf             = page.text.match('\d{3}\.?\d{3}\.?\d{3}\-?\d{2}').to_s
      content         = page.text

      if cpf.present?
        cnpj_or_cpf = cpf
      else
        cnpj_or_cpf = cnpj[2]
      end

      brokerage = BrokerageAccount.find_by(brokerage: note_number)

      if note_number.present?
        if brokerage.present?
          statement = Statement.find_by(statement_date: date)
          statement.content << content
          statement.save!
        else
          # TODO Account.last
          BrokerageAccount.create(account_id: Account.last.id,
                                  brokerage: note_number,
                                  number: client_number,
                                  account_number: cnpj_or_cpf)
          Statement.create(statement_date: date,
                            statement_file_id: statement_file.id,
                            brokerage_account_id: BrokerageAccount.last.id,
                            content: content)
        end
      end
    end
    statement_file.update(processed_at: DateTime.now)
  end
end
