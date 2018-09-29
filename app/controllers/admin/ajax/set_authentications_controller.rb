class Admin::Ajax::SetAuthenticationsController < Admin::BaseController
  skip_load_and_authorize_resource
  authorize_resource User
  before_action :verify_password, :load_user

  def update
    @user.skip_reconfirmation!
    @user.assign_attributes user_params

    if @user.save
      return render json: {}, status: :ok
    end

    render json: {errors: @user.errors.full_messages}, status: :bad_request
  end

  def destroy
    @user.assign_attributes confirmed_at: nil

    if @user.save
      return render json: {}, status: :ok
    end

    render json: {errors: ['Không thể thực hiện ngay bây giờ']}, status: :bad_request
  end

  private
  def verify_password
    unless current_user.valid_password? params[:my_password]
      current_user.errors.add :base, :wrong_password
      render json: {errors: current_user.errors.full_messages}, status: :bad_request
    end
  end

  def load_user
    unless (@user = User.find_by id: params[:id])
      render json: {errors: ['Không tìm thấy thành viên']}, status: :not_found
    end
  end

  def user_params
    params.merge! confirmed_at: Time.current, confirmation_token: nil,
      confirmation_sent_at: nil, unconfirmed_email: nil
    params.permit :email, :password, :confirmed_at, :confirmation_token,
      :confirmation_sent_at, :unconfirmed_email
  end
end
