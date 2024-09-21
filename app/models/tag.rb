class Tag < ApplicationRecord
  has_many :code_tags, dependent: :destroy
  has_many :codes, through: :code_tags

  validates :tag_name, presence: true, length: { maximum: 10 }, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    %w[tag_name]
  end
end
