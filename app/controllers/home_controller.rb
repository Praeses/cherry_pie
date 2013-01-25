class HomeController < ApplicationController

  def index
    @page = @current_site.home_page
  end

end
