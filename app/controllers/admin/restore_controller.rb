class Admin::RestoreController < Admin::BaseController
  skip_load_and_authorize_resource
  authorize_resource History
  authorize_resource Patient
  authorize_resource User

  def index
    users = User.with_deleted.where.not(deleted_at: nil).page(params[:page]).per 10
    users_histories = History.includes(:place, :admin).with_deleted.where.not(deleted_at: nil).page(params[:page]).per 10
    @payload = {
      users: {
        data: users,
        meta: pagination_meta(users)
      },
      users_histories: {
        data: users_histories,
        meta: pagination_meta(users_histories)
      }
    }
  end
end
