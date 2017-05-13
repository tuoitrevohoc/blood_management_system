class ContactsController < BaseController
  skip_load_and_authorize_resource
  authorize_resource class: false

  def new
  end

  def create
    ContactsMailer.contact(contact_params).deliver_now
    flash[:info] = "Thông tin đã được gửi, cám ơn đã liên hệ chúng tôi!"
    redirect_to action: :new
  end

  private
  def contact_params
    params.require(:contact).permit :name, :email, :subject, :content
  end
end
