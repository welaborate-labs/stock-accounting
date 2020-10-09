class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :name
      t.string :document
      t.text :address
      t.text :address_complement
      t.string :city
      t.string :state
      t.string :country
      t.string :zipcode
      t.string :phone_personal
      t.string :phone_business
      t.string :phone_mobile
      t.string :status

      t.timestamps
    end
  end
end
