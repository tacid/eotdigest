module ApplicationHelper
  def page_is?(page)
    return false unless page._?.to_s.is_a?(String)
    @controller_name, @action_name = *page.to_s.split('/')
    return (params[:controller] == @controller_name && params[:action] == @action_name) if @action_name
    return (params[:controller] == @controller_name)
  end
end
