class HomeController < ApplicationController

  def index
    @page = @current_site.home_page
    @pages = Page.for_site(@current_site).for_root()
    @fields = @page.fields
  end

end
