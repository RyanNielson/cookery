class CreateGroceryListItems < ActiveRecord::Migration[8.1]
  def change
    create_table :grocery_list_items do |t|
      t.references :grocery_list, null: false, foreign_key: true
      t.string :name
      t.string :quantity_text
      t.boolean :purchased, null: false, default: false

      t.timestamps
    end
  end
end
