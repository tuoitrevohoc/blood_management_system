class History < ApplicationRecord
  acts_as_paranoid

  attr_reader :deleted_by

  belongs_to :user
  belongs_to :place
  belongs_to :admin, class_name: User.name, foreign_key: :admin_id, optional: true
  belongs_to :patient, optional: true

  enum donation_type: [:whole_blood, :platelets]

  delegate :name, :address, to: :place, prefix: :place, allow_nil: true
  delegate :id, :name, :birthday, :gender, :blood_type, :facebook_account,to: :user,
    prefix: :user, allow_nil: true
  delegate :id, :name, to: :admin, prefix: :admin, allow_nil: true
  delegate :name, :birthday, :phone_number, :address, :pathological, :description,
    to: :patient, allow_nil: true, prefix: :patient

  validates :date, :donation_type, presence: true
  validates :platelet_count, numericality: {only_integer: true, greater_than: 0},
    if: -> {self.platelets? && self.platelet_count.present?}

  ransacker :donation_type, formater: proc {|type| donation_types[type]}

  scope :newest, -> {reorder date: :desc, created_at: :desc}
  scope :eldest, -> {reorder date: :asc}
  scope :this_week, -> date = Time.current do
    ransack(date_gteq: date.at_beginning_of_week, date_lteq: date.at_end_of_week).result
  end

  def next_donation_due_date
    self.date + Settings.minimum_frequency.try(self.donation_type).months
  end

  def has_patient?
    self.patient_id?
  end

  def deleted_by= user_id
    @deleted_by = user_id
  end

  private
  def phone_number_or_address
    if self.patient_phone_number.blank? && self.patient_address.blank?
      self.errors.add :base, :missing_phone_number_or_address
    end
  end

  def add_log
    SystemLog.create! action_type: :remove, target_type: History.name, target_id: self.id, actor_id: self.deleted_by
  end
end
