module ApplicationHelper
  def navbar(layout = nil)
    layout ||= controller.class._layout&.to_sym || "default"
    render "shared/navbar/#{layout}", layout: layout
  end

  def add_class(klass, options)
    options[:if] ? klass : ""
  end
end
