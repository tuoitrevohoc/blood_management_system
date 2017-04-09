class ProfilesController < ApplicationController
  before_action :set_form, only: [:edit, :update]

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
    params.require(:user).permit :name, :gender, :blood_type, :id_number,
      :phone_number, :address, :avatar, :email, :password, :password_confirmation,
      :is_suscribed_email, :is_public_profile, :is_volunteer
  end
end
