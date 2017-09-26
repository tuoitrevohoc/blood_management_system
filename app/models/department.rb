class Department < ApplicationRecord
  belongs_to :place
  has_many :patients

  validates :name, presence: true, uniqueness: {scope: :place_id, message: "đã có trong bệnh viện này."}
end
