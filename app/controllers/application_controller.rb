class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :setup_site
  layout :layout_by_resource

  def layout_by_resource
    return 'devise' if devise_controller?
    "application"
  end

  def setup_site
    @current_site = Site.find_or_create_by_url( request.host )
    Rails.application.config.action_mailer.default_url_options ||= {}
    Rails.application.config.action_mailer.default_url_options[:host] = request.host_with_port
  end

end
