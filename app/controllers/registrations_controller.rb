class RegistrationsController < Devise::RegistrationsController
  def new
    build_resource({})
    yield resource if block_given?
  end

  def create
    build_resource sign_up_params
    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :success, :signed_up
        sign_up resource_name, resource
        @success = true
      else
        set_flash_message! :warning, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        @success = false
      end
      render "registrations/create.js"
    else
      clean_up_passwords resource
      set_minimum_password_length
      render "registrations/new.js"
    end
  end
end
