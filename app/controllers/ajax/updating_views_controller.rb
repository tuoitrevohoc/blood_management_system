class Ajax::UpdatingViewsController < ApplicationController
  def article
    @article = Article.find_by_id params[:id]
    update_views @article
  end

  def event
    @event = Event.find_by_id params[:id]
    update_views @event
  end

  private
  def update_views object
    object.increment! :views
  rescue
  end
end
