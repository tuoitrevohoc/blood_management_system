class Admin::Ajax::DepartmentsController < Admin::BaseController
  before_action :load_place, only: [:new, :create]

  def index
    @places = Place.concat_name_address truncate: 40
  end

  def new
    @department = @place.departments.new
  end

  def create
  end

  private
  def load_place
    @place = Place.find_by id: params[:place_id]
  end
end
