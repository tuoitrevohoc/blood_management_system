class Ajax::RightSidebarController < BaseController
  skip_before_action :authenticate_user!
  skip_load_and_authorize_resource
  authorize_resource class: false

  def events
    @events = Event.available.not_expired.random.take 1
  end

  def articles
    @articles = Article.available.without_pinned.top_newest.random.take 3
  end
end
