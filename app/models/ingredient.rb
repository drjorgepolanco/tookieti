class Ingredient < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 3, maximum: 20 }

  has_many  :meals
  has_many  :recipes, through: :meals
end
