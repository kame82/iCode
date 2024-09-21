class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :name, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[github google_oauth2]

  has_many :codes, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    %w[name]
  end
end
