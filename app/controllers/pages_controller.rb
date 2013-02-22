class PagesController < ApplicationController

  respond_to :json
  before_filter :authenticate_any!,
    :only => [:create, :update, :destroy]


  def show
    @page = Page.for_site(@current_site).find_by_id( params[:id] ) || Page.for_site(@current_site).find_by_name( params[:id] )
    raise ActionController::RoutingError.new('Not Found') unless @page
    @page = @current_site.home_page
    @pages = Page.for_site(@current_site).for_root()
    @fields = @page.fields
    respond_to do |format|
      format.json do render json: {
        :id => @page.id,
        :fields => @page.fields
      }
      end
      format.html
    end
  end


  #def show
  #  @page = Page.find(params[:id])

  #  respond_to do |format|
  #    format.json do render json: {
  #      :id => @page.id,
  #      :fields => @page.fields
  #    }
  #    end
  #  end
  #end


  def create
    @page = Page.new(params[:page])
    respond_to do |format|
      if @page.save
        format.json { render json: @page, status: :created, location: @page }
      else
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    @page = Page.find(params[:id])
    authorize! :update, @page
    respond_to do |format|
      if @page.update_attributes(params[:page])
        #@page.fields = params[:fields]
        format.json { head :no_content }
      else
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end


end
