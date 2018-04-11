json.set! :statistics do
  json.set! :total_users, @user_size
  json.set! :total_histories, @history_size
  json.set! :total_patients, @patient_size
  json.set! :can_donate, @can_donate
end
