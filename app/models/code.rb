class Code < ApplicationRecord
  validates :title, presence: true, length: { maximum: 20 }

  belongs_to :user
end
