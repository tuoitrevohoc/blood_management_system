class Place < ApplicationRecord
  has_many :events
  has_many :histories
  has_many :users, through: :history_id

  class << self
    def concat_name_address truncate: false
      if truncate
        select "id, CONCAT(name, ' - ', IF(CHAR_LENGTH(address) > #{truncate},
          CONCAT(SUBSTR(address, 1, #{truncate}), '...'), address)) AS name"
      else
        select "id, CONCAT(name, ' - ', address) as name"
      end
    end
  end
end
