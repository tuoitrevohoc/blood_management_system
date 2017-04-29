class Event < ApplicationRecord
  belongs_to :place
  has_many :event_images

  validates :title, :image, :date_time, :place, :content, presence: true

  scope :newest, -> {order created_at: :desc}
end
