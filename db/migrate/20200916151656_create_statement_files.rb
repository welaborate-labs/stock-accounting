class CreateStatementFiles < ActiveRecord::Migration[6.0]
  def change
    create_table :statement_files do |t|
      t.datetime :processed_at

      t.timestamps
    end
  end
end
