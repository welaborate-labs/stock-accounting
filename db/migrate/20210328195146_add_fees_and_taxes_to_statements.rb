class AddFeesAndTaxesToStatements < ActiveRecord::Migration[6.1]
  def change
    add_column :statements, :liquidation_fee, :decimal
    add_column :statements, :registration_fee, :decimal
    add_column :statements, :terms_fee, :decimal
    add_column :statements, :ana_fee, :decimal
    add_column :statements, :exchange_fee, :decimal
    add_column :statements, :operational_fee, :decimal
    add_column :statements, :execution_fee, :decimal
    add_column :statements, :custody_fee, :decimal
    add_column :statements, :taxes, :decimal
    add_column :statements, :capital_gain_tax, :decimal
    add_column :statements, :other_fees, :decimal
  end
end
