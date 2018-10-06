class Admin::DashboardController < Admin::BaseController
  skip_load_and_authorize_resource
  authorize_resource class: false
  authorize_resource History

  def index
  end
end
