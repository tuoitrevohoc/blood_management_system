class Article < ApplicationRecord
  belongs_to :user

  mount_uploader :image, ImageUploader

  validates :title, presence: true, length: {maximum: 200}
  validates :content, presence: true, length: {maximum: 65535}

  scope :available, -> {where is_public: true}
  scope :newest, -> {order created_at: :desc}
end
