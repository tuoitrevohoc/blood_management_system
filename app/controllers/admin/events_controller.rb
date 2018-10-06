class Admin::EventsController < Admin::BaseController
  before_action :set_form, only: [:new, :create, :edit, :update]
  before_action :load_event, only: [:edit, :update, :destroy]

  def index
    @q = Event.newest.ransack params[:q]
    @events = @q.result.page(params[:page]).per 10
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

  def edit
  end

  def update
    @event.assign_attributes event_params
    if @event.save
      flash[:success] = "Đã lưu!"
      redirect_to admin_events_path
    else
      render :edit
    end
  end

  def destroy
    if @event.destroy
      flash[:success] = "Đã xóa sự kiện."
    else
      flash[:danger] = "Lỗi, thử lại sau."
    end
    redirect_to admin_events_path
  end

  private
  def event_params
    params[:event].merge! is_public: is_public?
    params[:event].merge! user_id: current_user.id if action_name == 'create'
    params.require(:event).permit :title, :image, :date_time, :place_id, :content, :is_public, :user_id
  end

  def is_public?
    params[:commit] == "public"
  end

  def set_form
    @form = Support::EventForm.new
  end

  def load_event
    render_404 unless (@event = Event.find_by id: params[:id])
  end
end
