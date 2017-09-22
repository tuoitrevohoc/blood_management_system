class Admin::PatientsController < Admin::BaseController
  before_action :load_form, only: [:new, :edit]

  def index
    @patients = Patient.includes(:department).all.page(params[:page]).per 10
  end

  def new
    @patient = Patient.new
  end

  def create
    @patient = Patient.new patient_params
    if @patient.save
      flash[:success] = "Bệnh nhân \"#{@patient.name}\" đã được tạo!"
      redirect_to admin_patients_path
    else
      load_form
      render :new
    end
  end

  def edit
  end

  def update
    if @patient.update patient_params
      flash[:success] = "Thay đổi đã được lưu!"
      redirect_to admin_patients_path
    else
      load_form
      render :edit
    end
  end

  def destroy
    patient = Patient.find_by id: params[:id]
    if patient && patient.destroy
      flash[:success] = "Bệnh nhân \"#{@patient.name}\" đã bị xoá!"
    else
      flash[:danger] = "Opps... Có lỗi xảy ra, không thể xoá ngay lúc này."
    end
  end

  private
  def patient_params
    params.require(:patient).permit :name, :birthday, :gender, :blood_type,
      :pathological, :room_number, :phone_number, :phone_number_2, :address,
      :history_of_pathology, :description, :department_id, :place_of_birth, :id_number
  end

  def load_form
    @form = Support::UserForm.new
  end
end
