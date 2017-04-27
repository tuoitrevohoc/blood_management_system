class ArticleDecorator < Draper::Decorator
  delegate_all

  def formated_timestamp
    I18n.l article.created_at, format: :article_timestamp
  end

  def first_paragraph
    limit = 500
    content_parsed = Nokogiri::HTML.parse(object.content).css("p").first
    original = content_parsed.present? ? content_parsed.text : strip_tags(object.content)
    original.length < limit ? original : original.first(limit) << "..."
  end
end
