class UsersMailer < Devise::Mailer
  include Devise::Controllers::UrlHelpers
  default template_path: "devise/mailer", from: "no-reply@bmsdn.org"

  def confirmation_instructions record, token, opts = {}
    return if record.email.blank?
    if record.is_signed_up_by_admin?
      @user = record
      @password = @user.password
      @place = @user.last_donated_place
      @token = token
      subject = t ".subject"
      mail to: @user.email, subject: subject do |format|
        format.html {render "devise/mailer/account_created"}
      end
    else
      @resource = record
      super
    end
  end
end
