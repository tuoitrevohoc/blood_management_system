class AdminHistory < ApplicationRecord
  belongs_to :user
  belongs_to :place, optional: true
  belongs_to :admin, class_name: User.name, foreign_key: :admin_id

  validates :user, :start_time, :end_time, :admin, presence: true
  validates :end_time, date: {after: :start_time}

  scope :available, -> current = Time.current do
    ransack(start_time_lteq: current, end_time_gteq: current).result
  end

  scope :with_details, -> do
    select('admin_histories.*, users.name admin_name, places.name place_name')
      .left_joins(:place, :admin)
  end
end
