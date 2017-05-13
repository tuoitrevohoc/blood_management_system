class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do
    flash[:warning] = "Access denied ApplicationController"
    render_404
  end

  protected
  def render_404
    render "shared/404", status: 404
  end
end
