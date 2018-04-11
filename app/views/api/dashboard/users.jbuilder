json.set! :data do
  json.set! :new_users do
    json.array! @new_users do |user|
      json.extract! user, :id, :name, :gender, :blood_type, :avatar, :created_at
    end
  end

  json.set! :recent_donors do
    json.array! @recent_donors do |user|
      json.extract! user, :id, :name, :gender, :blood_type, :avatar, :was_donating_at
    end
  end

  json.set! :top_donors do
    json.array! @top_donors do |user|
      json.extract! user, :id, :name, :gender, :blood_type, :avatar, :quantity
    end
  end

  json.set! :top_value, @top_value
end
