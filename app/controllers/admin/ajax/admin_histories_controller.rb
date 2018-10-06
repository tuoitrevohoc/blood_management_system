class Admin::Ajax::AdminHistoriesController < ApplicationController
  skip_load_and_authorize_resource
  authorize_resource AdminHistory
  before_action :load_admin_history

  def destroy
    if @admin_history.destroy
      return render json: {}, status: :ok
    end

    render json: {errors: ['Không thể xoá lúc này.']}, status: :bad_request
  end

  private
  def load_admin_history
    unless (@admin_history = AdminHistory.find_by_id params[:id])
      render json: {errors: ['Không tìm thấy.']}, status: :not_found
    end
  end
end
