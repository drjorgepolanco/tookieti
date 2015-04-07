class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.references :recipe, index: true
      t.references :ingredient, index: true

      t.timestamps null: false
    end
    add_foreign_key :meals, :recipes
    add_foreign_key :meals, :ingredients
  end
end
