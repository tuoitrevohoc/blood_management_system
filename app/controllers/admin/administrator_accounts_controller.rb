class Admin::AdministratorAccountsController < Admin::BaseController
  skip_load_and_authorize_resource
  authorize_resource User

  before_action :load_user, only: [:edit, :update, :destroy]
  before_action :set_form, only: [:edit, :update]
  before_action :verify_password, only: :update

  def index
    @q = User.all.ransack params[:q]
    @users = @q.result.page(params[:page]).per 10
    @form = Support::UserForm.new
    @stats = {
      total: @q.result.size,
      per_page: @users.size < 10 ? @users.size : 10
    }
  end

  def edit
    @admin_history = @user.admin_histories.new
  end

  def update
    if @user.update update_params
      flash[:success] = "Đã lưu."
    end
    @admin_history = @user.admin_histories.new
    render :edit
  end

  def destroy
    @user.deleted_by = current_user.id
    if @user.update(reason_for_deleting: params[:reason].presence) && @user.destroy
      message = "Đã xóa!"
      respond_to do |format|
        format.html do
          flash[:success] = message
          redirect_to admin_administrator_accounts_path
        end
        format.js do
          render json: {msg: message}, status: 200
        end
      end
    else
      message = "Xóa không thành công."
      respond_to do |format|
        format.html do
          flash[:danger] = message
          redirect_to admin_administrator_accounts_path
        end
        format.js do
          render json: {msg: message}, status: 400
        end
      end
    end
  end

  private
  def load_user
    unless (@user = User.find_by_id params[:id])
      flash[:danger] = "Không tìm thấy tài khoản."
      redirect_to admin_administrator_accounts_path
    end
  end

  def set_form
    @form = Support::UserForm.new
    @place_form = Support::PlaceForm.new
  end

  def verify_password
    unless current_user.valid_password? params[:password]
      @user.errors.add :password, :wrong
      @admin_history = @user.admin_histories.new
      render :edit
    end
  end

  def update_params
    params.require(:user).permit :role
  end
end
