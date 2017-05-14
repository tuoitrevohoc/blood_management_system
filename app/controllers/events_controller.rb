class EventsController < ApplicationController
  before_action :load_event, :authorize, only: :show

  def index
    @events = Event.includes(:place).available.newest.page(params[:page]).per 10
  end

  def show
    @event = @event.decorate
  end

  private
  def load_event
    render_404 unless (@event = Event.includes(:place).find_by title_slug: params[:slug])
  end

  def authorize
    authorize! action_name.to_sym, @event
  end
end
