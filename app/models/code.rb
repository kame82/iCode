class Code < ApplicationRecord
  validates :title, presence: true, length: { maximum: 20 }

  belongs_to :user
  mount_uploader :image, ImageUploader
  before_destroy :remove_image

  private
  def remove_image
    image.remove!
  rescue Exception => e
    logger.error(e.message)
  end
end
