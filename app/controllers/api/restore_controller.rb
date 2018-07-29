class Api::RestoreController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_load_and_authorize_resource
  authorize_resource History
  authorize_resource Patient
  authorize_resource User

  def users
    users = User.with_deleted.where.not(deleted_at: nil)
      .ransack(ransack_params).result
      .page(params[:page]).per 10
    render json: {users: users, meta: pagination_meta(users)}, status: 200
  end

  def histories
    histories = user ? user.histories.with_deleted.includes(:place, :admin).all : []
    render json: histories, status: 200
  end

  def update
    if user
      result = User.restore(params[:user_id]) && History.restore(user.histories.with_deleted.pluck :id)
      render json: {result: result}, status: 200
    end
  end

  def really_destroy
    if user && user.deleted_at?
      user.deleted_by = current_user.id
      result = user.really_destroy!
      render json: {result: result}, status: 200
    else
      render json: {result: false}, status: 404
    end
  end

  private
  def user
    User.with_deleted.find_by id: params[:user_id]
  end

  def ransack_params
    return nil if params[:q].blank?
    JSON.parse(params[:q])
  end
end
