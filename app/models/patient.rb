class Patient < ApplicationRecord
  belongs_to :department
  has_many :histories
  has_many :users, through: :histories

  enum gender: [:female, :male]
  enum blood_type: [:a_pos, :a_neg, :b_pos, :b_neg, :ab_pos, :ab_neg, :o_pos, :o_neg]

  delegate :name, :head_doctor, to: :department, allow_nil: true, prefix: :department

  validates :name, :gender, :blood_type, :phone_number, :address, :pathological, :department, presence: true

  scope :blood_type_compatible_with, -> blood_type {where blood_type: blood_type}
  scope :newest, -> {order created_at: :desc}
end
