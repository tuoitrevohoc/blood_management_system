class UsersController < ApplicationController
  before_action :load_user, :verify_accessible, only: :show

  def show
    @histories = @user.histories.includes :place
  end

  private
  def load_user
    redirect_to profile_path if current_user.id == params[:id].to_i && current_user.normal?
    render_404 unless (@user = User.find_by_id params[:id])
  end

  def verify_accessible
    unless @user.is_public_profile? || !current_user.normal?
      flash[:warning] = "Xin lỗi người dùng này không công khai thông tin."
      redirect_to root_path
    end
  end
end
