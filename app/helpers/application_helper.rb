module ApplicationHelper

  def navbar_link_to(name, options = {}, html_options = {}, &block)
    options[:class] = 'btn navbar-btn'
    link_to(name, options, html_options, &block)
  end

  def present(model, *args)
    klass = "#{model.class}Presenter".constantize
    presenter = klass.new(model, self, *args)
    yield(presenter) if block_given?
  end
end
