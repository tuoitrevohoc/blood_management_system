class HomeController < BaseController
  skip_before_action :authenticate_user!
  skip_load_and_authorize_resource
  authorize_resource class: false

  def index
    @events = Event.not_expired.available.oldest.first 4
    @event = @events.shift&.decorate
    @articles = Article.without_pinned.available.newest.first 6
    @pinned_articles = Article.pinned.available.all
  end
end
