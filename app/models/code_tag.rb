class CodeTag < ApplicationRecord
  belongs_to :code
  belongs_to :tag

  validates :code_id, uniqueness: { scope: :tag_id }
end
