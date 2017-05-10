module ApplicationHelper

  def navbar_link_to(name, options = {}, html_options = {}, &block)
    options[:class] = 'btn navbar-btn'
    link_to(name, options, html_options, &block)
  end
end
