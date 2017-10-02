class Department < ApplicationRecord
  belongs_to :place
  has_many :patients
end
