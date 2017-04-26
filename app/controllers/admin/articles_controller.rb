class Admin::ArticlesController < Admin::BaseController
  def new
    @article = Article.new
  end

  def create
    @article = Article.new article_params
    if @article.save
      flash[:success] = is_public? ? "Đã đăng bài lên trang chủ." : "Đã lưu vào nháp."
      redirect_to new_admin_article_path
    else
      render :new
    end
  end

  private
  def article_params
    params[:article].merge! is_public: is_public?, title_slug: make_slug
    params.require(:article).permit :title, :content, :image, :is_public, :title_slug
  end

  def is_public?
    params[:commit] == "public"
  end

  def make_slug
    params[:article][:title].parameterize  << "-" << SecureRandom.hex(3).upcase
  end
end
