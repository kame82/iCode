class Code < ApplicationRecord
  validates :title, presence: true, length: { maximum: 20 }
  enum is_public: { public: 0 , private: 1 }, _prefix: true

  belongs_to :user
  has_many :favorites, dependent: :destroy
  mount_uploader :image, ImageUploader
  before_destroy :remove_image

  private
  def remove_image
    image.remove!
  rescue Exception => e
    logger.error(e.message)
  end
end
