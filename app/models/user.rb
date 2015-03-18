class User < ActiveRecord::Base
  validates :first_name, presence: true, length: { maximum: 40 }
  validates :last_name,  presence: true, length: { maximum: 40 }
  validates :email,      presence: true, length: { maximum: 80 }
end
