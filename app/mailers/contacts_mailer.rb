class ContactsMailer < ApplicationMailer
  def contact params
    @params = params
    @mail_to = Settings.admin_email
    mail to: @mail_to, from: @params[:email], subject: @params[:subject]
  end
end
