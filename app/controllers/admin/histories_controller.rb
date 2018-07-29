require "addressable/uri"
class Admin::HistoriesController < Admin::BaseController
  before_action :load_user, only: :update
  before_action :load_history, only: :destroy

  def index
    @file_name = export_file_name[:name]
    respond_to do |format|
      format.html {load_data}
      format.js {load_data}
      format.xls do
        headers["Content-Disposition"] = "attachment; filename=\"#{@file_name}\""
        @histories = History.includes(:user, :place).newest.ransack(ransack_params).result.decorate
        @worksheet = export_file_name[:timestamp]
      end
    end
  end

  def new
    @user = User.new
    load_empty_data
  end

  def create
    @user = User.new
    @user.skip_confirmation_notification!
    if @user.update(user_params) # && update_patient_info(@user)
      @user.signed_up_by_admin!
      if @user.email.present?
        token = @user.confirmation_token
        UsersMailer.confirmation_instructions(@user, token).deliver
      else
        @user.skip_confirmation!
      end
      flash[:success] = "Đã tạo tài khoản và thêm 1 lịch sử hiến máu cho #{@user.name.try :titleize}."
      redirect_to new_admin_history_path
    else
      load_empty_data build_histories: false
      render :new
    end
  end

  def update
    if @user.update(user_params) # && update_patient_info(@user)
      # TODO: update add thank you letter later.
      sign_in @user, bypass: true if @user == current_user
      flash[:success] = "Đã thêm 1 lịch sử hiến máu cho #{@user.name.try :titleize}."
      redirect_to new_admin_history_path
    else
      load_empty_data build_histories: false
      render :new
    end
  end

  def destroy
    @history.deleted_by = current_user.id
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
    password = User.secure_random_password
    attribute_id = params[:user][:histories_attributes].keys.last
    param_date = params[:user][:histories_attributes][attribute_id][:date].to_date
    date = current_user.admin? ? param_date : Date.current
    params[:user].merge! password: password if password && !@user.encrypted_password?
    params[:user][:histories_attributes][attribute_id].merge! date: date,
      admin_id: current_user.id, is_verified: true
    params[:user].merge! email: nil if params[:user][:email].present?
    params.require(:user).permit :name, :email, :gender, :birthday, :id_number, :phone_number, :description,
      :phone_number_2, :address, :blood_type, :password, :lat, :lon, :facebook_account, :place_of_birth,
      histories_attributes: [
        :user_id, :date, :place_id, :donation_type, :platelet_count, :admin_id, :is_verified, :referer, :patient_id
      ]
  end

  def patient_params
    attribute_id = params[:user][:histories_attributes].keys.last
    params[:user][:histories_attributes][attribute_id].permit :patient_name, :patient_age,
      :patient_pathological, :patient_phone_number, :patient_address, :patient_description
  end

  def has_patient?
    patient_params[:patient_name].present? &&
      (patient_params[:patient_phone_number].present? || patient_params[:patient_address].present?)
  end

  def update_patient_info user
    if has_patient?
      history = user.histories.last
      if history.update patient_params
        true
      else
        append_error history, user
        false
      end
    else
      true
    end
  end

  def load_empty_data build_histories: true
    @users = []
    @user.histories.new if build_histories
    set_forms
    @patients = Patient.select(:name, :id, :blood_type, :address)
      .map do |patient|
        blood_type = t "users.blood_types.#{patient.blood_type}"
        text = "#{patient.name} (#{blood_type}) - #{patient.address}"
        [text, patient.id]
      end
  end

  def load_history
    render_404 unless (@history = History.find_by id: params[:id])
  end

  def append_error history, user
    history.errors.details.each do |attribute, errors|
      user.errors.details.merge! "histories.#{attribute}": errors
    end
    history.errors.messages.each do |attribute, msgs|
      user.errors.messages.merge! "histories.#{attribute}": msgs
    end
  end

  def export_file_name
    lastest_date = History.eldest.first.try :date
    newest_date = Date.current
    from_date = params[:q][:date_gteq].presence || lastest_date rescue lastest_date
    to_date = params[:q][:date_lteq].presence || newest_date rescue newest_date
    from_date = l from_date.to_date, format: :exp_date if from_date
    to_date = l to_date.to_date, format: :exp_date if to_date
    file_name = "danh_sach_hien_mau"
    slogan = "clb_hieu_va_thuong"
    {
      name: [file_name, from_date, to_date, slogan].compact.join("_") + ".xls",
      timestamp: [from_date, to_date].compact.join("_")
    }
  end

  def ransack_params
    uri = Addressable::URI.new
    uri.query = params[:q]
    uri.query_values
  end

  def load_data
    @q = History.includes(:user, :place, :admin).newest.ransack params[:q]
    @histories = @q.result.page(params[:page]).per 10
    @default_search_by = params[:search_by] || Settings.histories.search_items.donator
    @stats = {
      histories: @q.result.size,
      users: @q.result.pluck(:user_id).uniq.length
    }
  end
end
