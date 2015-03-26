class User < ActiveRecord::Base
  attr_accessor :remember_token
  VALID_EMAIL = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  before_save { email.downcase! }
  validates :first_name, presence: true, length: { maximum: 40 }
  validates :last_name,  presence: true, length: { maximum: 40 }
  validates :email,      presence: true, length: { maximum: 90 },
                         format:     { with: VALID_EMAIL       },
                         uniqueness: { case_sensitive: false   }
  has_secure_password
  validates :password,   presence: true, length: { minimum: 8  },
                         allow_blank: true

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
end
