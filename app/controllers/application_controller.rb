class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied, ActiveRecord::RecordNotFound do
    respond_to do |format|
      format.html {render_404 if Rails.env.production?}
      format.js {render js: "showNotification('404: Không tìm thấy trang yêu cầu.', 'danger');"}
    end
  end

  protected
  def render_404
    render "shared/404", status: 404
  end
end
