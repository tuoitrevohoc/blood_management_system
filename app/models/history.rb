class History < ApplicationRecord
  belongs_to :user
  belongs_to :place
  belongs_to :admin, class_name: User.name, foreign_key: :admin_id, optional: true

  enum donation_type: [:platelets, :directed]

  delegate :name, :address, to: :place, prefix: :place, allow_nil: true
  delegate :id, :name, to: :user, prefix: :user, allow_nil: true
  delegate :id, :name, to: :admin, prefix: :admin, allow_nil: true

  validates :date, :donation_type, presence: true
  validates :platelet_count, numericality: {only_integer: true, greater_than: 0},
    if: -> {self.directed?}

  ransacker :donation_type, formater: proc {|type| donation_types[type]}

  scope :newest, -> {order date: :desc}
end
