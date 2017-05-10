module ApplicationHelper

  def navbar_link_to(name, options, html_options = {})
    html_options[:class] = 'btn navbar-btn'
    link_to(name, options, html_options)
  end
end
