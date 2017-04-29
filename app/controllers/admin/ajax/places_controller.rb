class Admin::Ajax::PlacesController < ApplicationController
  def new
    @place = Place.new place_params
  end

  def create
    @place = Place.create place_params
  end

  private
  def place_params
    params.require(:place).permit :name, :address, :latitude, :longitude, :formatted_address
  end
end
