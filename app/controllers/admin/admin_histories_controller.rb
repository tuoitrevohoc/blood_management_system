class Admin::AdminHistoriesController < Admin::BaseController
  before_action :load_user, :set_form
  before_action :verify_password, :verify_updatable

  def create
    @admin_history = @user.admin_histories.build admin_history_params
    @admin_history.admin_id = current_user.id
    if @admin_history.save
      flash[:success] = "Đã lưu."
    else
      render "admin/administrator_accounts/edit" and return
    end
    @admin_history = @user.admin_histories.new
    render "admin/administrator_accounts/edit"
  end

  private
  def admin_history_params
    params.require(:admin_history).permit :start_time, :end_time, :place_id
  end

  def load_user
    unless (@user = User.find_by_id params[:administrator_account_id])
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
      @admin_history = @user.admin_histories.new
      @admin_history.errors.add :base, :wrong_password
      render "admin/administrator_accounts/edit"
    end
  end

  def verify_updatable
    unless @user.limited?
      @admin_history = @user.admin_histories.new
      @admin_history.errors.add :base, :not_a_limited_admin
      render "admin/administrator_accounts/edit"
    end
  end
end
