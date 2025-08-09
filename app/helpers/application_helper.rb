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

  def severity_badge(severity)
    base_class = "badge"
    severity_class = case severity.to_sym
    when :low
      "badge-info"
    when :medium
      "badge-warning"
    when :high
      "badge-danger"
    else
      "badge-light"
    end
    content_tag(:span, severity.humanize, class: "#{base_class} #{severity_class}")
  end

  def office_sender_options
    {
      vc_office: { name: "Prof. Engr. Akpofure Rim-Rukeh", title: "Vice Chancellor" },
      registrar: { name: "Mrs. O.D. Ivwighreghweta", title: "Registrar" },
      bursary: { name: "Mr. Garba Yau", title: "Bursar" },
      dean_of_students: { name: "Dr. Alex O. Ogedegbe", title: "Dean of Student Affairs" }
    }
  end

  def render_svg(name, options = {})
    path = Rails.root.join("app", "assets", "images", "#{name}.svg")
    return "" unless File.exist?(path)

    svg = File.read(path)
    doc = Nokogiri::HTML::DocumentFragment.parse(svg)
    svg_tag = doc.at_css "svg"

    options.each { |attr, value| svg_tag[attr.to_s] = value }

    doc.to_html.html_safe
  end
end
