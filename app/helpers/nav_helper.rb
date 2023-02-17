# frozen_string_literal: true

module NavHelper
  def nav_link(name, path)
    link_to name, path, class: "nav-link #{current_page?(path) ? "active" : "link-dark"}"
  end
end
