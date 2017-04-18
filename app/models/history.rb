class History < ApplicationRecord
  belongs_to :user
  belongs_to :place

  enum volume: [:ml_250, :ml_350, :ml_450]

  delegate :name, :address, to: :place, prefix: :place, allow_nil: true

  scope :newest, -> {order date: :desc}
end
