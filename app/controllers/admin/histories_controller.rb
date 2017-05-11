class Admin::HistoriesController < Admin::BaseController
  before_action :load_user, only: :update
  before_action :verify_accessible
  before_action :load_history, only: :destroy

  def index
    @q = History.includes(:user, :place, :admin).newest.ransack params[:q]
    @histories = @q.result.page(params[:page]).per 10
  end

  def new
    @user = User.new
    load_empty_data
  end

  def create
    @user = User.new
    @user.skip_confirmation_notification!
    if @user.update user_params
      @user.signed_up_by_admin!
      token = @user.confirmation_token
      UsersMailer.confirmation_instructions(@user, token).deliver if @user.email.present?
      flash[:success] = "Đã tạo tài khoản và thêm 1 lịch sử hiến máu cho #{@user.name&.titleize}."
      redirect_to new_admin_history_path
    else
      load_empty_data build_histories: false
      render :new
    end
  end

  def update
    if @user.update user_params
      # TODO: update add thank you letter later.
      sign_in @user, bypass: true if @user == current_user
      flash[:success] = "Đã thêm 1 lịch sử hiến máu cho #{@user.name&.titleize}."
      redirect_to new_admin_history_path
    else
      load_empty_data build_histories: false
      render :new
    end
  end

  def destroy
    if @history.destroy
      flash[:success] = "Đã xóa lịch sử hiến máu."
    else
      flash[:danger] = "Lỗi! không thể xóa thành công."
    end
    redirect_to admin_histories_path
  end

  private
  def set_forms
    @user_form =  Support::UserForm.new
    @history_form =  Support::HistoryForm.new places: current_user.available_places
  end

  def load_user
    unless (@user = User.includes(:admin_histories).find_by id: params[:user][:id])
      flash[:danger] = "Không tìm thấy thành viên."
      redirect_to new_admin_history_path
    end
  end

  def user_params
    # TODO: Update current admin place id later.
    password = User.secure_random_password
    attribute_id = params[:user][:histories_attributes].keys.last
    params[:user].merge! password: password if password && !@user.encrypted_password?
    params[:user][:histories_attributes][attribute_id].merge! date: Date.current,
      admin_id: current_user.id, is_verified: true
    params.require(:user).permit :name, :email, :gender, :birthday, :id_number,
      :phone_number, :address, :blood_type, :password, :lat, :lon,
      histories_attributes: [:volume, :date, :place_id]
  end

  def load_empty_data build_histories: true
    @users = []
    @user.histories.new if build_histories
    set_forms
  end

  def verify_accessible
    if !current_user.admin? && current_user.admin_histories.available.empty?
      flash[:warning] = "Truy cập không được phép!"
      redirect_to admin_root_path
    end
  end

  def load_history
    render_404 unless (@history = History.find_by id: params[:id])
  end
end
