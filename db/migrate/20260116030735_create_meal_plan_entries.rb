class CreateMealPlanEntries < ActiveRecord::Migration[8.1]
  def change
    create_table :meal_plan_entries do |t|
      t.references :meal_plan, null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true
      t.date :planned_on

      t.timestamps
    end
  end
end
