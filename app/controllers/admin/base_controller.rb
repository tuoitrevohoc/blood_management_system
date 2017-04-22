class Admin::BaseController < ApplicationController
  before_action :admin_and_limited_only!
  layout "application_admin"

  protected
  def admin_and_limited_only!
    unless current_user.admin? || current_user.limited?
      flash[:danger] = "Bạn không có quyền truy cập."
      redirect_to root_path
    end
  end
end
