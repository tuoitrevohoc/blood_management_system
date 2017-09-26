class Admin::Ajax::PlacesDepartmentsController < Admin::BaseController
  skip_load_and_authorize_resource
  authorize_resource Place
  before_action :convert_request_format

  def new
    @place = Place.new
    @department = @place.departments.new
  end

  def create
    @place = Place.create place_params
    if @place.errors.blank?
      @department = @place.departments.last
    end
  end

  private
  def convert_request_format
    request.format = :js
  end

  def place_params
    params.require(:place).permit :name, :address, :latitude, :longitude,
      :formatted_address, :is_hospital, departments_attributes: [:name, :head_doctor]
  end
end
