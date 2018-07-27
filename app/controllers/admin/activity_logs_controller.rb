class Admin::ActivityLogsController < Admin::BaseController
  skip_load_and_authorize_resource
  authorize_resource History
  authorize_resource Patient
  authorize_resource User

  def index
  end
end
