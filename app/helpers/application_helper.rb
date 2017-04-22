module ApplicationHelper
  def full_title page_title = ""
    base_title = t "base_title"
    page_title.present? ? "#{page_title} | #{base_title}" : base_title
  end

  def active_class url
    "active" if request.original_fullpath.include? url
  end

  def visible_unsorted_icon criteria
    params[:q] && (params[:q][:s]&.include? criteria.to_s) ? "hidden" : "unsorted"
  end

  def is_disabled_field? object, field
    object.persisted? && object.try(field).present?
  end

  def avatar_for user, size: 130
    version = size < 80 ? :thumb : :medium
    image_tag user.avatar.try(version), alt: user.name.titleize, class: "img", size: size
  end
end
