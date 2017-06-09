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
    when "directed"
      "warning"
    end
    "<span class='label label-#{type}'>#{I18n.t('histories.donation_types.' + donation_type)}<span>".html_safe
  end
end
