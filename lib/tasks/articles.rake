require "nokogiri"
require "open-uri"
require "slugify"

namespace :articles do
  task default_article: :environment do
    puts "Start importing..."
    count = 0
    errors = 0
    error_files = []
    files = Dir["#{Rails.root}/db/master/static_pages/**/*.html"]
    files.each do |path|
      file = File.open path
      file_content = file.read
      html_content = Nokogiri::HTML.parse file_content
      title = html_content.css("title").first.text
      next if Article.find_by title: title
      content = file_content.gsub "<title>#{title}</title>", ""
      title_slug = Slugify.create(title) << "-" << SecureRandom.hex(3).upcase
      user_id = User.first.id
      article = Article.new title: title, user_id: user_id, content: content,
        title_slug: title_slug, is_public: true, is_pinned: true
      if article.save
        count += 1
      else
        errors += 1
        error_files << path
        puts article.errors.full_messages.pretty_inspect
      end
    end
    puts "****************************************"
    puts "Imported #{count} files successfull."
    puts "Couldn't import these files: #{error_files.pretty_inspect}." if error_files.any?
  end
end
