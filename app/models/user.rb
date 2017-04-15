class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :histories
  has_many :events
  has_many :posts

  enum gender: [:female, :male]
  enum blood_type: [:type_a, :type_b, :type_ab, :type_o]
  enum role: [:normal, :limited, :admin]

  ransacker :gender, formater: proc {|v| genders[v]}
  ransacker :blood_type, formater: proc {|v| blood_types[v]}

  mount_uploader :avatar, AvatarUploader

  validates :name, :gender, :blood_type, :id_number, :phone_number, presence: true, allow_nil: true
  validates :email, presence: true, format: Settings.email_regex
  validates :password, length: {minimum: 6}, presence: true, allow_nil: true

  def status
    return :unknown unless self.histories.any?
    freq = Settings.minimum_frequency.try(self.gender)&.months || Settings.default_frequency
    distance = (Date.current - self.histories.last&.date).days
    case true
    when distance > freq
      :can_donate
    when distance > freq - 1.month
      :almost
    else
      :cannot_donate
    end
  end

  def can_donate?
    status == :can_donate
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
  end
end
