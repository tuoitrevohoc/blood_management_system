class Api::DashboardController < ApplicationController
  def statistics
    users = User.includes :reverse_histories
    @user_size = users.size
    @history_size = History.distinct.size
    @patient_size = Patient.distinct.size
    @can_donate = users.to_a.count {|user| user.can_donate?}
  end

  def genders
    male_size = User.male.size
    female_size = User.female.size
    @male = male_size * 100 / (male_size + female_size)
  end

  def blood_types
    @data = User.count_blood_types
  end

  def users
    @new_users = User.latest 30.days.ago
    @recent_donors = User.recent.page(params[:page]).per 10
    top_histories = User.count_histories.load
    # top 3 by value -> element's index = 2
    @top_value = top_histories.map {|u| u.quantity}.uniq[2]
    @top_donors = top_histories.select {|u| u.quantity >= @top_value}
  end
end
