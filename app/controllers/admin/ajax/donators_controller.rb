class Admin::Ajax::DonatorsController < Admin::BaseController
  skip_load_and_authorize_resource
  authorize_resource User

  def index
    
  end

  private
end
