class ArticleDecorator < Draper::Decorator
  delegate_all
  # For using helper `strip_tags`
  include ActionView::Helpers::SanitizeHelper

  def formated_timestamp
    I18n.l article.created_at, format: :article_timestamp
  end

  def first_paragraph inline: false
    limit = 500
    content_parsed = Nokogiri::HTML.parse(object.content).css("p").first
    original = content_parsed.present? ? content_parsed.text : strip_tags(object.content)
    text = original.length < limit ? original : original.first(limit) << "..."
    inline ? concat_lines(text) : text
  end

  def display_status
    lb_class = :default
    lb_text = :private
    if is_public?
      lb_class = :primary
      lb_text = :Public
    end
    "<span class=\"label label-#{lb_class}\">#{lb_text}</span>".html_safe
  end

  private
  def concat_lines paragraph
    paragraph.gsub(/\r\n/, ". ")
  end
end
