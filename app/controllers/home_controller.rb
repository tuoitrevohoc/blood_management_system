class HomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @events = Event.not_expired.available.oldest.first 4
    @event = @events.shift.decorate
    @articles = Article.without_pinned.available.newest.first 6
    @pinned_articles = Article.pinned.all
  end
end
