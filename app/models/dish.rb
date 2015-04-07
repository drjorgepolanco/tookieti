class Dish < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :cuisine
end
