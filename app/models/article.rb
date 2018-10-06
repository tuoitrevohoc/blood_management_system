class Article < ApplicationRecord
  belongs_to :user

  mount_uploader :image, ImageUploader

  validates :title, presence: true, length: {maximum: 200}
  validates :content, presence: true, length: {maximum: 65535}

  scope :available, -> {where is_public: true}
  scope :newest, -> {order created_at: :desc}
  scope :random, -> {order "RAND()"}
  scope :top_newest, -> time = 7.days.ago do
    ransack(created_at_gteq: time).result
  end
  scope :without_pinned, -> {where is_pinned: false}
  scope :pinned, -> {where is_pinned: true}

  after_save :set_title_slug

  private
  def set_title_slug
    return unless self.title_changed?
    unique_slug = "#{Slugify.create(self.title)}-#{self.id}"
    self.update_column :title_slug, unique_slug
  end
end
