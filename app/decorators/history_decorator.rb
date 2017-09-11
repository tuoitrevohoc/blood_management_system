class HistoryDecorator < Draper::Decorator
  delegate_all

  def timestamp
    I18n.l date, format: :default_date
  end

  def display_donation_type
    return nil unless donation_type
    type = case donation_type
    when "platelets"
      "success"
    when "whole_blood"
      "warning"
    end
    "<span class='label label-#{type}'>#{I18n.t('histories.donation_types.' + donation_type)}<span>".html_safe
  end

  def display_user_birthday
    if (birthday = object.try :user_birthday)
      I18n.l birthday, format: :default_date
    end
  end

  def display_user_gender
    if (gender = object.try :user_gender)
      I18n.t "users.genders.#{gender}"
    end
  end

  def display_user_blood_type
    if (blood_type = object.try :user_blood_type)
      I18n.t "users.blood_types_excel.#{blood_type}"
    end
  end

  def display_donation_type_excel
    if (donation_type = object.try :donation_type)
      I18n.t "histories.donation_types.#{donation_type}"
    end
  end

  def display_user_name
    if (user_name = object.try :user_name)
      user_name.titleize
    end
  end

  def cell_data_type attribute
    case attribute
    when :display_user_name, :display_user_gender, :display_user_blood_type,
         :display_donation_type_excel, :place_name, :user_facebook_account
      :String
    when :display_user_birthday
      :DateTime
    else
      :String
    end
  end

  def cell_style_id attribute
    case attribute
    when :display_user_birthday
      :s62
    else
      nil
    end
  end
end
