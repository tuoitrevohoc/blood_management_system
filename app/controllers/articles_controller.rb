class ArticlesController < ApplicationController
  before_action :load_article, :authorize, only: :show

  def index
    @articles = Article.available.without_pinned.newest.page(params[:page]).per 10
  end

  def show
    @article = @article.decorate
  end

  private
  def load_article
    render_404 unless (@article = Article.find_by title_slug: params[:slug])
  end

  def authorize
    authorize! action_name.to_sym, @article
  end
end
