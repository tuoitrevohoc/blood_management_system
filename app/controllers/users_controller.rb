class UsersController < BaseController
  before_action :load_user, only: :show

  def show
    @histories = @user.histories.includes :place
  end

  private
  def load_user
    redirect_to profile_path if current_user.id == params[:id].to_i && current_user.normal?
    @user = User.find_by_id params[:id]
  end
end
