namespace :sql_full_group_by do
  desc "Setting full group by mode for MySQL"

  task enable: :environment do
    queries = [
      "set global sql_mode='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';",
      "set session sql_mode='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';"
    ]
    begin
      queries.each do |query|
        ActiveRecord::Base.connection.execute query
        puts "executed: `#{query}`"
      end
    rescue
    end
  end
end
