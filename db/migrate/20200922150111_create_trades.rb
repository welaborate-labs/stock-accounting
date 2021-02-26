class CreateTrades < ActiveRecord::Migration[6.0]
  def change
    create_table :trades do |t|
      t.belongs_to :statement, index: true
      t.string :ticker
      t.integer :direction
      t.integer :status, default: 0
      t.integer :quantity
      t.decimal :price, :decimal, precision: 8, scale: 2
      t.datetime :transacted_at

      t.timestamps
    end
  end
end
