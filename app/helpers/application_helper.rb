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
end
