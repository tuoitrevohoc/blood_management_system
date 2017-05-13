require "slugify"

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
    @event.assign_attributes update_params
    @event.assign_attributes title_slug: make_slug if @event.title_changed?
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
    params[:event].merge! is_public: is_public?, user_id: current_user.id, title_slug: make_slug
    params.require(:event).permit :title, :image, :date_time, :place_id, :content,
      :title_slug, :is_public, :user_id
  end

  def update_params
    params[:event].merge! is_public: is_public?
    params.require(:event).permit :title, :image, :date_time, :place_id, :content, :is_public
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

  def make_slug
    Slugify.create(params[:event][:title]) << "-" << SecureRandom.hex(3).upcase
  end
end
