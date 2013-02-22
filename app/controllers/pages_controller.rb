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


  #spine.js is calling create on update :'( not time to fix
  def create
    @page = Page.find_by_id(params[:id]) || Page.new(params[:page])
    @page.site_id = @current_site.id
    authorize! :update, @page
    @page.name = params[:name] || @page.name
    respond_to do |format|
      if @page.save
        format.json do render json: {
          :id => @page.id,
          :fields => @page.fields,
          :href => @page.href,
          :name => @page.name,
        }
        end
      else
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    create
  end

  #def update
  #  @page = Page.find(params[:id])
  #  authorize! :update, @page
  #  respond_to do |format|
  #    if @page.update_attributes(params[:page])
  #      format.json { head :no_content }
  #    else
  #      format.json { render json: @page.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end


  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end


end
