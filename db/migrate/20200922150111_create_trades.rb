class CreateTrades < ActiveRecord::Migration[6.0]
  def change
    create_table :trades do |t|
      t.belongs_to :statement, index: true
      t.string :ticker
      t.integer :direction
      t.boolean :open
      t.boolean :close
      t.integer :quantity
      t.integer :price
      t.datetime :transacted_at

      t.timestamps
    end
  end
end
