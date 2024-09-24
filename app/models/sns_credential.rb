class SnsCredential < ApplicationRecord
  belongs_to :user

  validates :provider, presence: true
end
