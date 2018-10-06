class Event < ApplicationRecord
  belongs_to :place
  has_many :event_images

  mount_uploader :image, ImageUploader

  validates :title, :date_time, :place, :content, presence: true

  delegate :name, :address, :latitude, :longitude, :formatted_address, to: :place, prefix: :place, allow_nil: true

  scope :newest, -> {order date_time: :desc}
  scope :oldest, -> {order :date_time}
  scope :available, -> current = Time.current {where is_public: true}
  scope :not_expired, -> current = Time.current {where "date_time > ?", current}
  scope :random, -> {order "RAND()"}

  after_save :set_title_slug

  def date_time
    I18n.l attributes["date_time"], format: :full if date_time?
  end

  def is_expired?
    attributes["date_time"] + 4.hours < Time.current
  end

  private
  def set_title_slug
    return unless self.title_changed?
    unique_slug = "#{Slugify.create(self.title)}-#{self.id}"
    self.update_column :title_slug, unique_slug
  end
end
