class UserDecorator < Draper::Decorator
  delegate_all

  def status_display
    I18n.t "users.statuses.#{object.status}"
  end

  def status_title
    return unless self.histories.any? && !can_donate?
    freq = Settings.minimum_frequency.try(gender)&.months || Settings.default_frequency
    histories.last&.date + freq
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
    type = case blood_type
    when "type_a"
      "<span class='label label-success'>Nhóm A</span>"
    when "type_b"
      "<span class='label label-info'>Nhóm B</span>"
    when "type_ab"
      "<span class='label label-warning'>Nhóm AB</span>"
    when "type_o"
      "<span class='label label-danger'>Nhóm O</span>"
    end
    type&.html_safe
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
