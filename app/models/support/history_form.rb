class Support::HistoryForm
  attr_reader :places

  def initialize places: []
    @places = places
  end

  def volumes
    History.volumes.keys.map {|v| [I18n.t("histories.volumes.#{v}"), v]}
  end

  def places
    @places.map {|e| ["#{e.name} - #{e.address}", e.id]}
  end
end
