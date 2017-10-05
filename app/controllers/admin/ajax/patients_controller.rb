class Admin::Ajax::PatientsController < ApplicationController
  before_action :load_history, except: :index

  def index
    patients = Patient.blood_type_compatible_with donor_blood_type
    render json: {data: ActiveModel::Serializer::CollectionSerializer.new(patients, ajax_request: true)}, status: 200
  end

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

  def donor_blood_type
    Settings.blood_donor_scheme.try params[:donor_blood_type]
  end
end
