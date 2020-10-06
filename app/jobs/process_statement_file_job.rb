class ProcessStatementFileJob < ApplicationJob
  queue_as :default

  def perform(statement_file_id)
    # Do something later
  end
end
