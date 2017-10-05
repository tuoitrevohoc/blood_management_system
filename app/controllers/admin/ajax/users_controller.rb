class Admin::Ajax::UsersController < Admin::BaseController
  before_action :load_user, :set_form, only: :show

  def index
    params.merge! q: Hash.new
    params[:q].merge! name_or_email_or_address_or_id_number_or_phone_number_cont: params[:keyword].downcase
    @users = User.includes(:histories).ransack(params[:q]).result.decorate
  end

  def show
  end

  private
  def load_user
    @user = User.find_by id: params[:id]
    @user.histories.build
  end

  def set_form
    @user_form =  Support::UserForm.new
    @history_form =  Support::HistoryForm.new places: current_user.available_places
    @patients = Patient.select(:name, :id, :blood_type, :address)
      .map do |patient|
        blood_type = t "users.blood_types.#{patient.blood_type}"
        text = "#{patient.name} (#{blood_type}) - #{patient.address}"
        [text, patient.id]
      end
  end
end
