class Support::PlaceForm
  def places
    Place.concat_name_address(truncate: 40).map {|place| [place.name, place.id]}
  end
end
