class Admin::Ajax::PlacesDepartmentsController < Admin::BaseController
  skip_load_and_authorize_resource
  authorize_resource Place
  before_action :convert_request_format

  def new
  end

  def create

  end

  private
  def convert_request_format
    request.format = :js
  end
end
