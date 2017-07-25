module ApplicationHelper
  def full_title page_title = ""
    base_title = t "base_title"
    page_title.present? ? "#{page_title} | #{base_title}" : base_title
  end

  def active_class url
    url.slice! ".html"
    "active" if request.original_fullpath.include? url
  end

  def visible_unsorted_icon criteria
    params[:q] && (params[:q][:s]&.split(" ")&.first == criteria.to_s) ? "hidden" : "unsorted"
  end

  def is_disabled_field? object, field
    object.persisted? && object.try(field).present?
  end

  def avatar_for user, size: 130, width: nil
    version = case true
    when size > 80
      :medium
    when size < 40
      :small
    else
      :thumb
    end

    if width.present?
      image_tag user.avatar.try(version)&.url, alt: user.name&.titleize, class: "img",
        style: "width:#{width};height:auto;"
    else
      image_tag user.avatar.try(version)&.url, alt: user.name&.titleize, class: "img"
    end
  end

  def format_phone_number phone_number
    return if phone_number.blank?
    phone_number = phone_number.gsub(/[" ", ".", "_"]/, "").gsub("-", "").to_i
    "0#{number_to_phone phone_number, delimiter: " "}"
  end

  def crawl_facebook_info username
    return unless username
    profile_url = "#{Settings.fb_search_path.home}/#{username}"
    web_contents = open(profile_url) {|f| f.read}
    html_content = Nokogiri::HTML.parse(web_contents)
    avatar_tag = html_content.css("img.profilePic.img").first
    cover_name = html_content.css("span#fb-timeline-cover-name").first
    {
      cover_name: cover_name.children.text,
      avatar_src: avatar_tag.attributes["src"].value,
      profile_url: "#{Settings.fb_search_path.home}/#{username}"
    }
  rescue
    {
      cover_name: username.titleize,
      avatar_src: "",
      profile_url: "#{Settings.fb_search_path.people}#{username}"
    }
  end

  def is_searching_patient?
    params[:search_by] == Settings.histories.search_items.patient
  end
end
