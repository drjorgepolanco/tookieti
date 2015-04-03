class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many   :likes
  validates  :title,       presence: true, length: { maximum: 100 }
  validates  :description, presence: true, length: { minimum: 10  }
  validates  :steps,       presence: true, length: { minimum: 10  }
  validates  :user_id,     presence: true
  default_scope -> { order(updated_at: :desc) }
end
