class Admin::BloodsMapsController < Admin::BloodsController
  skip_load_and_authorize_resource
  authorize_resource class: false
  authorize_resource History

  layout false

  def maps
    super
  end
end
