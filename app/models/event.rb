class Event < ApplicationRecord
  belongs_to :place
  has_many :event_images

  mount_uploader :image, ImageUploader

  validates :title, :image, :date_time, :place, :content, presence: true

  scope :newest, -> {order created_at: :desc}
  scope :available, -> current = Time.current do
    where "is_public = ? and date_time >= ?", true, current
  end

  def date_time
    I18n.l attributes["date_time"], format: :full if date_time?
  end
end
