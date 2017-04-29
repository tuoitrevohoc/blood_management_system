class Admin::EventsController < Admin::BaseController
  before_action :set_form, only: [:new, :create]

  def index
    @events = Event.newest.page(params[:page]).per 10
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new event_params
    if @event.save
      flash[:success] = is_public? ? "Đã đăng sự kiện lên trang chủ" : "Đã Lưu"
      redirect_to admin_events_path
    else
      render :new
    end
  end

  private
  def event_params
    params[:event].merge! is_public: is_public?
    params.require(:event).permit :title, :image, :date_time, :place_id, :content
  end

  def is_public?
    params[:commit] == "public"
  end

  def set_form
    @form = Support::EventForm.new
  end
end
