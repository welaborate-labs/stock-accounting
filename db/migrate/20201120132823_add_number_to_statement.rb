class AddNumberToStatement < ActiveRecord::Migration[6.0]
  def change
    add_column :statements, :number, :string
  end
end
