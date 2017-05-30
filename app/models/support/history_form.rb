class Support::HistoryForm
  attr_reader :places

  def initialize places: []
    @places = places
  end

  def volumes
    vols = History.volumes.keys.map {|v| [I18n.t("histories.volumes.#{v}"), v]}
    vols << ["Khác...", "other_volume"]
  end

  def other_volumes
    I18n.t("histories.other_volumes").map {|k,v | [v, k]}
  end

  def places
    @places.map {|e| ["#{e.name} - #{e.address}", e.id]}
  end
end
