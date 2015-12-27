module ApplicationHelper
  require 'embedly'
  require 'json'

  # Give url and get embedded frame for the url by embedly
  def display(url)
    embedly_api = Embedly::API.new(key: ENV['EMBEDLY_API_KEY'])
    obj = embedly_api.oembed :url => url
    (obj.first.html).html_safe
  end

  def is_active_controller(controller_name)
      params[:controller] == controller_name ? "active" : nil
  end

  def is_active_action(action_name)
      params[:action] == action_name ? "active" : nil
  end
end