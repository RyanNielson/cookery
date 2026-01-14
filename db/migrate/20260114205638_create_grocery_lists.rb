class CreateGroceryLists < ActiveRecord::Migration[8.1]
  def change
    create_table :grocery_lists do |t|
      t.string :name
      t.text :selected_recipe_ids
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
