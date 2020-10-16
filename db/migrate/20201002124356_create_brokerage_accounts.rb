class CreateBrokerageAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :brokerage_accounts do |t|
      t.belongs_to :account, null: false, foreign_key: true
      t.integer :brokerage
      t.string :number

      t.timestamps
    end
  end
end
