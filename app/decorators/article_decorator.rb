class ArticleDecorator < Draper::Decorator
  delegate_all

  def formated_timestamp
    I18n.l article.created_at, format: :article_timestamp
  end

  def first_paragraph
    limit = 500
    original = Nokogiri::HTML.parse(object.content).css("p").first.text
    original.length < limit ? original : original.first(limit) << "..."
  end
end
