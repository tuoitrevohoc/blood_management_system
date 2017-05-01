class EventsController < ApplicationController
  before_action :load_event, only: :show

  def index
    @events = Event.available.newest.page(params[:page]).per 10
  end

  def show
    @event = @event.decorate
  end

  def load_event
    render_404 unless (@event = Event.find_by title_slug: params[:slug])
  end
end
