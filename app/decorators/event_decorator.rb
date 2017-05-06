class EventDecorator < ArticleDecorator
  delegate_all

  def display_status_2
    label = if object.date_time > Time.current
      "<span class='label label-success'>Sắp diễn ra</span>"
    else
      "<span class='label label-default'>Đã qua</span>"
    end
    label.html_safe
  end

  def formated_timestamp
    I18n.l date_time.to_datetime, format: :article_timestamp
  end
end
