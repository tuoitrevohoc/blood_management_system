class Ajax::RightSidebarController < ApplicationController
  skip_before_action :authenticate_user!

  def events
    @events = Event.available.newest.first 3
  end

  def articles
    @articles = Article.available.newest.first 3
  end
end
