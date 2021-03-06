class Patient < ApplicationRecord
  acts_as_paranoid

  attr_reader :deleted_by

  belongs_to :department
  has_many :histories
  has_many :users, through: :histories
  has_many :patient_images, as: :imageable, dependent: :destroy

  enum gender: [:female, :male]
  enum blood_type: [:a_pos, :a_neg, :b_pos, :b_neg, :ab_pos, :ab_neg, :o_pos, :o_neg]

  delegate :name, :head_doctor, to: :department, allow_nil: true, prefix: :department

  validates :name, :gender, :blood_type, :phone_number, :address, :pathological, :department, presence: true

  scope :blood_type_compatible_with, -> blood_type {where blood_type: blood_type}
  scope :newest, -> {order created_at: :desc}

  after_real_destroy :add_log

  def deleted_by= user_id
    @deleted_by = user_id
  end

  private
  def add_log
    SystemLog.create! action_type: :remove, target_type: Patient.name, target_id: self.id, actor_id: self.deleted_by
  end
end
