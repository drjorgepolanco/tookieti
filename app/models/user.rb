class User < ActiveRecord::Base
  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  before_save { email.downcase! }
  validates :first_name, presence: true, length: { maximum: 40 }
  validates :last_name,  presence: true, length: { maximum: 40 }
  validates :email,      presence: true, length: { maximum: 80 },
                         format:     { with: VALID_EMAIL       },
                         uniqueness: { case_sensitive: false   }
  has_secure_password
  validates :password,   presence: true, length: { minimum: 8  }
end
