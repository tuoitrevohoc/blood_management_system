class Place < ApplicationRecord
  has_many :events
  has_many :histories
  has_many :users, through: :history_id
end
