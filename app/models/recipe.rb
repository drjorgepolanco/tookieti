class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many   :likes
  validates  :title,       presence: true, length: { maximum: 100 }
  validates  :description, presence: true, length: { minimum: 10  }
  validates  :steps,       presence: true, length: { minimum: 10  }
  validates  :prep_time,   presence: true
  validates  :user_id,     presence: true
  default_scope -> { order(updated_at: :desc) }
  mount_uploader :picture, PictureUploader
  validate       :picture_size
  
  def total_likes
    self.likes.size
  end

  private

    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "la imagen debe ser menor de 5MB")
      end
    end
end
