module ApplicationHelper
  def navbar(style = :default)
    render "shared/navbars/#{style}", container: true
  end
end
