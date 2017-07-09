class UsersController < BaseController
  before_action :load_user, only: :show
  before_action :set_form, only: :edit

  def show
    @histories = @user.histories.includes :place
    @fb_info = crawl_facebook_info @user.facebook_account
  end

  def edit
  end

  def update
    if @user.update user_params
      flash[:success] = "Thay đổi đã được lưu!"
      redirect_to @user
    else
      set_form
      render :edit
    end
  end

  private
  def load_user
    redirect_to profile_path if current_user.id == params[:id].to_i && current_user.normal?
    @user = User.find_by_id params[:id]
  end

  def set_form
    @form = Support::UserForm.new
  end

  def user_params
    params.require(:user).permit :name, :gender, :blood_type, :id_number, :phone_number,
      :address, :formatted_address, :lat, :lon,  :phone_number_2, :facebook_account
  end
end
