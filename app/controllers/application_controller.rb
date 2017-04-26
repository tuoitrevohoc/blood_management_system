class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  rescue_from CanCan::AccessDenied do
    render_404
  end

  protected
  def render_404
    render "shared/404", status: 404
  end
end
