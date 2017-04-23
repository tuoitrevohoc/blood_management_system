class HistoryDecorator < Draper::Decorator
  delegate_all

  def display_volume
    I18n.t "histories.volumes.#{volume}"
  end
end
