class Ajax::HistoriesController < BaseController
  before_action :load_history, only: [:show, :update]

  def show
    @history = @history.decorate
  end

  def update
    @history.update patient_params
    @history = @history.decorate
  end

  private
  def load_history
    @history = History.find_by_id params[:id]
    render js: "showNotification('Không tìm thấy trang yêu cầu', 'danger');" unless @history
  end

  def patient_params
    params.require(:history).permit :patient_name, :patient_age, :patient_description,
      :patient_phone_number, :patient_address, :patient_pathological
  end
end
