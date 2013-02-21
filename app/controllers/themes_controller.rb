class ThemesController < ApplicationController

  respond_to :json
  before_filter :authenticate_any!



  def update
    @site = @current_site
    authorize! :update, @site
    @site.theme = params[:id]

    respond_to do |format|
      if @site.save()
        format.json { head :no_content }
      else
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end

  end


end
