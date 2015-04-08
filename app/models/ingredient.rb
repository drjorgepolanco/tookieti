class Ingredient < ActiveRecord::Base
  before_save :downcase_name
  validates   :name, presence: true, length: { minimum: 3, maximum: 20 }, 
                               uniqueness: { case_sensitive: false   }

  has_many    :meals
  has_many    :recipes, through: :meals

  private

    def downcase_name
      self.name = name.downcase
    end
end
