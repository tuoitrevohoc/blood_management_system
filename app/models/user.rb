class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :histories
  has_many :events
  has_many :posts

  enum gender: [:female, :male]
  enum blood_type: [:type_a, :type_b, :type_ab, :type_o]
  enum role: [:normal, :limited, :admin]

  mount_uploader :avatar, AvatarUploader

  validates :name, :gender, :blood_type, :id_number, :phone_number, presence: true, allow_nil: true
  validates :email, presence: true, format: Settings.email_regex
  validates :password, length: {minimum: 6}, presence: true, allow_nil: true
end
