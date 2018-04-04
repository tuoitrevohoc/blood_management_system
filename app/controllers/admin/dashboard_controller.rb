class Admin::DashboardController < Admin::BaseController
  skip_load_and_authorize_resource
  authorize_resource class: false

  def index
  end
end
