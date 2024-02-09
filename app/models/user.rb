# frozen_string_literal: true

# deviseを使ったUserモデル
class User < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy, inverse_of: :visitor
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy,
                                   inverse_of: :visited

  mount_uploader :avatar, AvatarUploader
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]

  validates :uid, uniqueness: { scope: :provider }, unless: -> { provider.blank? }

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.name = auth.info.name
      user.password = Devise.friendly_token[0, 20]
      user.avatar = auth.info.image
    end
  end
end
