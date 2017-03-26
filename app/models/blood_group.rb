class BloodGroup < ApplicationRecord
  has_many :users

  enum group: [:a, :b, :ab, :o]
end
