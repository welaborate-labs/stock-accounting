class CreateStatements < ActiveRecord::Migration[6.0]
  def change
    create_table :statements do |t|
      t.datetime :statement_date
      t.belongs_to :statement_file, null: false, foreign_key: true

      t.timestamps
    end
  end
end
