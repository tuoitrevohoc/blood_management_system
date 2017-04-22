class AdminHistory < ApplicationRecord
  belongs_to :user
  belongs_to :place
  belongs_to :admin, class_name: User.name, foreign_key: :admin_id

  validates :user, :start_time, :end_time, :admin_id, presence: true
  validates :end_time, date: {after: :start_time}

  scope :available, -> current = Time.current do
    ransack(start_time_lteq: current, end_time_gteq: current).result
  end
end
