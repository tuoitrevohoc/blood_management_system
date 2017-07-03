class History < ApplicationRecord
  belongs_to :user
  belongs_to :place
  belongs_to :admin, class_name: User.name, foreign_key: :admin_id, optional: true

  enum donation_type: [:whole_blood, :platelets]

  delegate :name, :address, to: :place, prefix: :place, allow_nil: true
  delegate :id, :name, to: :user, prefix: :user, allow_nil: true
  delegate :id, :name, to: :admin, prefix: :admin, allow_nil: true

  validates :date, :donation_type, presence: true
  validates :platelet_count, numericality: {only_integer: true, greater_than: 0},
    if: -> {self.platelets? && self.platelet_count.present?}
  validates :patient_name, :patient_pathological, presence: true, if: -> {self.has_patient?}
  validate :phone_number_xor_address, if: :has_patient?

  ransacker :donation_type, formater: proc {|type| donation_types[type]}

  scope :newest, -> {order date: :desc}

  def next_donation_due_date
    self.date + Settings.minimum_frequency.try(self.donation_type).months
  end

  def has_patient?
    self.patient_name? && (self.patient_phone_number? || self.patient_address?)
  end

  private
  def phone_number_xor_address
    unless self.patient_phone_number.blank? ^ self.patient_address.blank?
      self.errors.add :base, :missing_phone_number_or_address
    end
  end
end
