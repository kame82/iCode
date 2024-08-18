class Code < ApplicationRecord
  validates :title, presence: true, length: { maximum: 20 }

  belongs_to :user
  mount_uploader :image, ImageUploader
end
