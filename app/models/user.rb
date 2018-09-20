class User < ApplicationRecord
  acts_as_paranoid
  attr_reader :is_signed_up_by_admin, :deleted_by
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :histories, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :histories_created, class_name: History.name, foreign_key: :admin_id, dependent: :destroy
  has_many :admin_histories, dependent: :destroy
  has_many :admin_histories_created, class_name: AdminHistory.name, foreign_key: :admin_id, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :patients, through: :histories, class_name: History.name, foreign_key: :patient_id

  accepts_nested_attributes_for :histories, allow_destroy: true

  enum gender: [:female, :male]
  enum blood_type: [:a_pos, :a_neg, :b_pos, :b_neg, :ab_pos, :ab_neg, :o_pos, :o_neg]
  enum role: [:normal, :limited, :admin]

  ransacker :gender, formater: proc {|v| genders[v]}
  ransacker :blood_type, formater: proc {|v| blood_types[v]}
  ransacker :role, formater: proc {|r| roles[r]}

  mount_uploader :avatar, AvatarUploader

  validates :name, :gender, :blood_type, :id_number, :phone_number, presence: true, allow_nil: true
  validates :email, format: Settings.email_regex, if: -> {self.email.present?}
  validates :password, length: {minimum: 6}, presence: true, allow_nil: true

  before_save downcase_email: -> {self.email.downcase! if self.email.present?}
  after_real_destroy :add_log

  scope :blood_type_compatible_with, -> blood_type {where blood_type: blood_type}
  scope :latest, -> time = Time.current do
    ransack(created_at_gteq: time).result
      .order(created_at: :desc)
  end
  scope :recent, -> do
    select("histories.user_id, MAX(histories.date) as was_donating_at, users.*")
      .joins(:histories)
      .group(:id)
      .order "was_donating_at desc"
  end
  scope :count_histories, -> do
    select("COUNT(users.id) AS quantity, users.*")
      .joins(:histories)
      .group(:id)
      .order "quantity DESC"
  end
  scope :with_last_history, -> do
    select("MAX(histories.date) AS was_donating_at,
      IF(histories.donation_type = 1, 'platelets', 'whole_blood') as donation_type,
      users.*")
      .joins("LEFT JOIN histories ON histories.user_id = users.id")
      .group "users.id"
  end

  def lastest_history
    self.histories.eldest.last
  end

  def status
    return :unknown unless self.try(:was_donating_at).present?
    next_donation_due_date = self.was_donating_at +
      Settings.minimum_frequency.try(self.donation_type).months
    case true
    when Date.current >= next_donation_due_date
      :can_donate
    when Date.current < next_donation_due_date - 7.days
      :cannot_donate
    else
      :almost
    end
  end

  def can_donate?
    status == :can_donate
  end

  def cannot_donate?
    status == :cannot_donate
  end

  def last_donated_place
    histories.newest.first.place
  end

  def signed_up_by_admin! *args
    @is_signed_up_by_admin = args[0].nil? ? true : args[0]
  end

  def is_signed_up_by_admin?
    @is_signed_up_by_admin
  end

  def available_places current = Time.current
    return Place.all if admin?

    available_admin_histories = admin_histories.available
    return Place.all if available_admin_histories.any? {|admin_history| admin_history.place_id.nil?}

    places = available_admin_histories.pluck :place_id
    Place.where id: places
  end

  def deleted_by= user_id
    @deleted_by = user_id
  end

  class << self
    def sort_non_attribute collection, criteria
      criteria = criteria.split " "
      collection = collection.to_a
      collection.sort_by! {|record| record.try criteria[0]}
      collection.reverse! if criteria[1].downcase == "desc"
    rescue ArgumentError
    ensure
      return collection
    end

    def search_non_attribute collection, criteria
      key = criteria.keys.first
      val = criteria.values.first.to_sym
      collection = collection.to_a.select {|record| record.try(key) == val}
    rescue ArgumentError
    ensure
      return collection
    end

    def secure_random_password
      SecureRandom.hex 4
    end

    def secure_random_uuid
      SecureRandom.uuid
    end

    def count_blood_types
      query = <<-SQL
        SELECT
            blood_type,
            COUNT(blood_type) AS q,
            COUNT(blood_type) / (SELECT COUNT(blood_type) FROM users) * 100 AS per
        FROM
            users
        GROUP BY blood_type
      SQL
      User.find_by_sql(query).map do |record|
        blood_type = record.try :blood_type
        quantity = record.try(:q)
        if (quantity > 0)
          {
            blood_type: blood_type,
            name: blood_type ? I18n.t("users.blood_types.#{blood_type}") : I18n.t("users.undefined_blood_type"),
            quantity: quantity,
            percentage: record.try(:per).to_f
          }
        end
      end.compact
    end

    def count_by_months limit = 12
      UserQuery.new.count_by_months(limit).reverse
    end
  end

  protected
  def email_required?
    false
  end

  private
  def add_log
    SystemLog.create! action_type: :remove, target_type: User.name, target_id: self.id,
      actor_id: self.deleted_by, description: self.reason_for_deleting
  end
end
