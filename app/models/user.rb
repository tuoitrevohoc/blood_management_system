class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  belongs_to :blood_group
  has_many :histories
  has_many :events
  has_many :posts

  enum gender: [:female, :male]
  enum role: [:normal, :limited, :admin]
end
