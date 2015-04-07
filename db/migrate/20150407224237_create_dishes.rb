class CreateDishes < ActiveRecord::Migration
  def change
    create_table :dishes do |t|
      t.references :recipe, index: true
      t.references :cuisine, index: true

      t.timestamps null: false
    end
    add_foreign_key :dishes, :recipes
    add_foreign_key :dishes, :cuisines
  end
end
