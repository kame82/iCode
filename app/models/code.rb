class Code < ApplicationRecord
  validates :title, presence: true, length: { maximum: 20 }
  enum is_public: { public: 0 , private: 1 }, _prefix: true

  validate :validation_empty_code

  belongs_to :user
  has_many :favorites, dependent: :destroy

  mount_uploader :image, ImageUploader
  before_destroy :remove_image

  has_many :code_tags, dependent: :destroy
  has_many :tags, through: :code_tags

  def save_tags(code_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - code_tags
    new_tags = code_tags - current_tags

    # 古いタグを削除
    old_tags.each do |old_tag|
      self.tags.delete Tag.find_by(tag_name: old_tag)
    end

    # 新しいタグを追加
    new_tags.each do |new_tag|
      add_tag = Tag.find_or_create_by(tag_name: new_tag)
      self.tags << add_tag unless self.tags.include?(add_tag)
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[title]
  end

  def self.ransackable_associations(auth_object = nil)
    ["tags", "user"]
  end

  def validation_empty_code
    if body_html.blank? && body_css.blank? && body_js.blank?
      errors.add(:base, "コードを入力してください")
    end
  end

  private
  def remove_image
    image.remove!
  rescue Exception => e
    logger.error(e.message)
  end
end
