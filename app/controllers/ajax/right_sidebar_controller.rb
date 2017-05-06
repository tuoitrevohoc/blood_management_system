class Ajax::RightSidebarController < ApplicationController
  skip_before_action :authenticate_user!

  def events
    @events = Event.available.not_expired.random.take 1
  end

  def articles
    @articles = Article.available.without_pinned.top_newest.random.take 3
  end
end
