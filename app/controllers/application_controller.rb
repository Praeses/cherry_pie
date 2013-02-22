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
    @current_site.theme ||= "apple"
    Rails.application.config.action_mailer.default_url_options ||= {}
    Rails.application.config.action_mailer.default_url_options[:host] = request.host_with_port
    theme @current_site.theme
    @pages = Page.for_site(@current_site).for_root()
  end

  def authenticate_any!
    if admin_signed_in?
      true
    else
      authenticate_user!
    end
  end

  def current_admin_or_user
    @current_admin_user = current_admin || current_user
    @current_admin_user
  end


  def current_ability
    @current_ability ||= ::Ability.new(current_admin_or_user)
  end


end
