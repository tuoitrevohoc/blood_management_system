class History < ApplicationRecord
  belongs_to :user
  belongs_to :place
  belongs_to :admin, class_name: User.name, foreign_key: :admin_id, optional: true

  enum volume: [:ml_250, :ml_350, :ml_450]

  delegate :name, :address, to: :place, prefix: :place, allow_nil: true
  delegate :id, :name, to: :user, prefix: :user, allow_nil: true
  delegate :id, :name, to: :admin, prefix: :admin, allow_nil: true

  scope :newest, -> {order date: :desc}
end
