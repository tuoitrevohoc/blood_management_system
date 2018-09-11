class UserQuery < ApplicationQuery
  attr_reader :relation

  def initialize relation = User.all
    @relation = relation.extending Scopes
  end

  def count_by_months limit = 12
    relation.extract_months_and_count
      .group("month_year")
      .order("month_year DESC")
      .limit limit
  end

  module Scopes
    def extract_months_and_count
      select "DATE_FORMAT(created_at, '%Y/%m') month_year, COUNT(id) total"
    end
  end
end
