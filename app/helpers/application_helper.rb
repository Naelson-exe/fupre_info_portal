module ApplicationHelper
  include Pagy::Frontend
  def format_date(date)
    date.strftime("%B %d, %Y")
  end

  def truncate_html(text, length: 100, omission: "...")
    truncate(strip_tags(text), length: length, omission: omission)
  end

  def active_link_to(text, path, **options)
    classes = options[:class] || ""
    classes << " active" if current_page?(path)
    link_to text, path, options.merge(class: classes)
  end

  def status_badge(status)
    base_class = "badge"
    status_class = case status.to_sym
    when :published
                     "badge-success"
    when :draft
                     "badge-secondary"
    when :archived
                     "badge-danger"
    else
                     "badge-light"
    end
    content_tag(:span, status.humanize, class: "#{base_class} #{status_class}")
  end

  def search_result_path(result)
    if result.is_a?(Post)
      post_path(result)
    elsif result.is_a?(Event)
      event_path(result)
    else
      "#"
    end
  end

  def sort_link_to(name, column, **options)
    direction = (column.to_s == params[:sort] && params[:direction] == "asc") ? "desc" : "asc"
    link_to name, request.params.merge(sort: column, direction: direction), **options
  end
end
