class AddAccountToStatementFiles < ActiveRecord::Migration[6.0]
  def change
    add_reference :statement_files, :account, null: false, foreign_key: true
  end
end
