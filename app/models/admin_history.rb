class AdminHistory < ApplicationRecord
  belongs_to :user
  belongs_to :place
  belongs_to :admin, class_name: User.name, foreign_key: :admin_id

  validates :user, :start_time, :end_time, :admin_id, presence: true
end
