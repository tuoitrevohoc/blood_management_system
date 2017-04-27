class Ajax::RightSidebarController < ApplicationController
  skip_before_action :authenticate_user!

  def events
  end

  def articles
    @articles = Article.available.newest.first 3
  end
end
