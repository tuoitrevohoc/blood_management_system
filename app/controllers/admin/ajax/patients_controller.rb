class Admin::Ajax::PatientsController < ApplicationController
  before_action :load_history

  def update
    @patient = Patient.find_by id: params[:patient_id]
    @history.update(patient: @patient) if @history && @patient
  end

  def destroy
    if @history && @history.update(patient: nil)
      flash[:success] = "Đã xoá liên kết."
    else
      flash[:danger] = "Không tìm thấy hoặc không thể xoá. Vui lòng thử lại sau."
    end
    redirect_to request.referer || admin_patients_path
  end

  private
  def load_history
    @history = History.find_by id: params[:id]
  end
end
