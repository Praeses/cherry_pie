class HomeController < ApplicationController

  def index
    @page = @current_site.home_page
    @fields = @current_site.home_page.fields.to_json
  end

end
