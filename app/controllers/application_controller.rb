class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :setup_site

  def setup_site
    @current_site = Site.find_or_create_by_url( request.host )
  end

end
