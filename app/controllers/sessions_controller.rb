class SessionsController < Devise::SessionsController
  def new
    self.resource = resource_class.new sign_in_params
    yield resource if block_given?
  end

  def create
    self.resource = warden.authenticate! auth_options
    set_flash_message! :success, :signed_in
    sign_in resource_name, resource
    yield resource if block_given?
    render :new
  end

  def destroy
    signed_out = Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message! :success, :signed_out if signed_out
    yield if block_given?
    respond_to_on_destroy
  end

  protected
  def sign_in_params
    devise_parameter_sanitizer.sanitize :sign_in
  end
end
