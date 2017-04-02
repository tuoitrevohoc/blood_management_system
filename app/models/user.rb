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
  enum blood_type: [:type_a, :type_b, :type_ab, :type_o]
  enum role: [:normal, :limited, :admin]
end
