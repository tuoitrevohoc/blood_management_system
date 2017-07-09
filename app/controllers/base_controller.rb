class BaseController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!
  include ApplicationHelper

  protected
  def render_404
    super
  end
end
