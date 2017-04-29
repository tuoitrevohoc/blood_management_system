class Support::EventForm
  def places
    Place.all.map {|e| ["#{e.name} - #{e.address}", e.id]}
  end
end
