class Admin::AdministratorAccountsController < Admin::BaseController
  before_action :load_user, only: [:edit, :update, :destroy]
  before_action :set_form, only: [:edit, :update]
  before_action :verify_password, :verify_accessible, only: [:update, :destroy]

  def index
    @q = User.all.ransack params[:q]
    @users = @q.result.page(params[:page]).per 10
    @form = Support::UserForm.new
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
    if @user.destroy
      flash[:success] = "Đã xóa!"
    else
      flash[:danger] = "Xóa không thành công."
    end
    redirect_to admin_administrator_accounts_path
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

  def verify_accessible
    if current_user == @user
      @user.errors.add :base, :access_denied
      @admin_history = @user.admin_histories.new
      render :edit
    end
  end

  def update_params
    params.require(:user).permit :role
  end
end
