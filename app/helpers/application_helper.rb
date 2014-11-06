module ApplicationHelper
  def page_title
    params[:controller].capitalize.gsub('_', ' ')
  end
end
