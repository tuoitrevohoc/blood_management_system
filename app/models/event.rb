class Event < ApplicationRecord
  belongs_to :place
  has_many :event_images
end
