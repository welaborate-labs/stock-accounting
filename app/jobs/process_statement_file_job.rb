class ProcessStatementFileJob < ApplicationJob
  queue_as :default

  def perform(statement_file_id:)
    statement_file = StatementFile.find(statement_file_id)

    reader = PDF::Reader.new(StringIO.new(statement_file.file.download))

    statement = nil
    previous_statement_number = nil

    reader.pages.each do |page|
      statement_number = page.text.match('\d{6}').to_s

      if statement && previous_statement_number && previous_statement_number == statement_number
        statement.content << '\n\n'
        statement.content << '=====PAGE====='
        statement.content << '\n\n'
        statement.content << page.text
      elsif !previous_statement_number || previous_statement_number != statement_number
        statement.save if statement
        statement = statement_file.statements.new(content: page.text, number: statement_number)

        unless statement.valid?
          statement = nil
        end
      end

      previous_statement_number = statement_number
    end
    statement_file.update(processed_at: DateTime.now)
  end
end
