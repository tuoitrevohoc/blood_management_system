class ProfilesController < BaseController
  skip_load_and_authorize_resource
  authorize_resource class: false
  before_action :set_form, only: [:edit, :update]

  def show
    @user = current_user.decorate
    @histories = current_user.histories.includes(:place).newest
    @fb_info = crawl_facebook_info @user.facebook_account
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update profile_params
    sign_in @user, bypass: true if params[:user][:password].present?
    redirect_to edit_profile_path if params[:reload]
  end

  private
  def set_form
    @form = Support::UserForm.new
  end

  def profile_params
    current_prams = params.require(:user).permit :name, :gender, :blood_type, :id_number,
      :phone_number, :address, :avatar, :email, :password, :password_confirmation,
      :is_suscribed_email, :is_public_profile, :is_volunteer, :formatted_address,
      :lat, :lon, :phone_number_2, :facebook_account, :place_of_birth, :description
    geo_data = [:formatted_address, :lat, :lon]
    geo_data.each do |attribute|
      current_prams.reject! {|key, value| value.blank?}
    end
    current_prams
  end
end
