class Support::HistoryForm
  attr_reader :places

  def initialize places: []
    @places = places
  end

  def places
    @places.map {|e| ["#{e.name} - #{e.address}", e.id]}
  end
end
