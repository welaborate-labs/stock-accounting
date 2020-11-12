class AddContentToStatement < ActiveRecord::Migration[6.0]
  def change
    add_column :statements, :content, :text
  end
end
