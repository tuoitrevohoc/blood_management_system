class Admin::Ajax::PatientImagesController < ApplicationController
  skip_load_and_authorize_resource
  authorize_resource Patient
  before_action :load_patient_image, only: :destroy

  def destroy
    if @patient_image.destroy
      return render json: {msg: "Đã xoá!"}, status: :ok
    end

    render json: {msg: "Không thể xoá hình ảnh lúc này."}, status: :bad_request
  end

  private
  def load_patient_image
    unless (@patient_image = PatientImage.find_by id: params[:id])
      render json: {msg: "Không tìm thấy hình ảnh."}, status: :not_found
    end
  end
end
