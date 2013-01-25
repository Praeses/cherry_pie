class HomeController < ApplicationController

  def index
    @page = @current_site.home_page
    @fields = @page.fields_hash
  end

end
