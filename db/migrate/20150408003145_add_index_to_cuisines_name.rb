class AddIndexToCuisinesName < ActiveRecord::Migration
  def change
    add_index :cuisines, :name, unique: true
  end
end
