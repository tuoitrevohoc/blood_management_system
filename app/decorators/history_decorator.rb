class HistoryDecorator < Draper::Decorator
  delegate_all

  def display_volume
    I18n.t "histories.volumes.#{volume}"
  end

  def timestamp
    I18n.l date, format: :default_date
  end

  def volume_label
    lb_class = case volume.to_sym
    when :ml_250
      "info"
    when :ml_350
      "success"
    when :ml_450
      "warning"
    else
      "danger"
    end
    "<span class='label label-#{lb_class}'>#{display_volume}</span>".html_safe
  end
end
