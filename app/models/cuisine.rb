class Cuisine < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 3, maximum: 20 }

  has_many  :dishes
  has_many  :recipes, through: :dishes
end
