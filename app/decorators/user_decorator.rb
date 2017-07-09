require "open-uri"

class UserDecorator < Draper::Decorator
  delegate_all
  include ApplicationHelper
  include ActionView::Helpers::AssetTagHelper

  def status_display
    I18n.t "users.statuses.#{object.status}"
  end

  def status_title
    return unless self.histories.any? && !can_donate?
    I18n.l histories.last.try(:next_donation_due_date), format: :default_date rescue nil
  end

  def status_class
    case object.status
    when :can_donate
      "success"
    when :almost
      "primary"
    when :cannot_donate
      "warning"
    when :unknown
      "default"
    end
  end

  def display_blood_type
    return unless blood_type
    lb_class = case blood_type.match(Settings.common_blood_type_regex)[0]
    when "a"
      "success"
    when "b"
      "info"
    when "ab"
      "warning"
    when "o"
      "danger"
    end
    "<span class='label label-#{lb_class}'>#{I18n.t("users.blood_types." + blood_type)}</span>".html_safe
  end

  def display_gender
    type = case gender
    when "male"
      "<span class='label label-danger'>Nam</span>"
    when "female"
      "<span class='label label-success'>Nữ</span>"
    end
    type&.html_safe
  end

  def display_role
    type = case role
    when "admin"
      "<span class='label label-danger'>Admin</span>"
    when "limited"
      "<span class='label label-info'>Limited</span>"
    else
      "<span class='label label-success'>Member</span>"
    end
    type&.html_safe
  end
end
