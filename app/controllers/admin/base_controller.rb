class Admin::BaseController < BaseController
  layout "application_admin"

  def current_ability
    @current_ability ||= AdminAbility.new current_user
  end

  rescue_from CanCan::AccessDenied do
    flash[:warning] = "Access denied Admin::BaseController"
    if current_user&.normal?
      render "shared/404", layout: "application", status: 404
    else
      render_403
    end
  end

  protected
  def render_404
    render "shared/404_admin", status: 404
  end

  def render_403
    render "shared/403_admin", status: 403
  end
end
