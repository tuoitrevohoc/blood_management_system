class EventDecorator < Draper::Decorator
  delegate_all

  def display_status
    label = if object.date_time > Time.current
      "<span class='label label-success'>Sắp diễn ra</span>"
    else
      "<span class='label label-default'>Đã qua</span>"
    end
    label.html_safe
  end
end
