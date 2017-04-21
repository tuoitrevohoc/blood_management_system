class Support::HistoryForm
  def volumes
    History.volumes.keys.map {|v| [I18n.t("histories.volumes.#{v}"), v]}
  end

  def places
    Place.all.map {|e| ["#{e.name} - #{e.address}", e.id]}
  end
end
