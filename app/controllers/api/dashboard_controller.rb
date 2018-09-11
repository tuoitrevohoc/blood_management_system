class Api::DashboardController < ApplicationController
  def statistics
    users = User.with_last_history
    @user_size = users.length
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

  def weekly
    real_data = History.date_between(selected_dates)
      .group(:date)
      .count(:id)
      .map {|k, v| {t("date.weekdays.#{k.strftime("%a").downcase}") => v}}
      .reduce(:merge) || {}
    @data = generate_week_dates.merge! real_data
  end

  def monthly
    @type = params[:type].downcase.presence
    klass = (@type || "User").classify.constantize
    @data = []
    if Settings.allowed_weekly_data.include? @type
      real_data = klass.count_by_months.inject({}) do |list, month|
        list.merge! month.month_year => {month.month_year => month.total}
      end
      @data = generate_last_n_months.merge(real_data)
        .sort_by {|month, _| month.to_date}
        .last(12)
        .to_h
        .values
        .map {|e| e.map {|k, v| {month_year: k, total: v}}}.flatten
    end
  end

  private
  def selected_dates
    if params[:dates].blank?
      params[:dates] = [
        7.days.ago.at_beginning_of_week,
        7.days.ago.at_end_of_week
      ]
    else
      params[:dates].map do |d|
        date = d.presence || Date.current
        Time.zone.parse(date).to_date
      end
    end
  end

  def generate_week_dates
    (selected_dates[0]..selected_dates[1]).inject({}) do |list, date|
      list.merge! t("date.weekdays.#{date.strftime("%a").downcase}") => 0
    end
  end

  def generate_last_n_months n = 12
    n.downto(1).inject({}) do |list, i|
      key = i.months.ago.strftime("%Y/%m")
      list.merge! key => {key => 0}
    end
  end
end
