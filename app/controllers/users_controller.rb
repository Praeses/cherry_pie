class UsersController < ApplicationController

  before_filter :authenticate_any!, :except => [:index, :show]
  load_and_authorize_resource :except => [:index, :show]

  # GET /users
  # GET /users.json
  def index
    @page = @current_site.users_page
    @fields = @page.fields
    @users = User.for(current_admin_or_user)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @users }
    end
  end

  def show
    @user = User.find_by_id(params[:id]) || User.find_by_full_name(params[:id].gsub(/_/, " ") )
    @page = @user.pages.first
    @fields = @page.fields
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new()

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create

    @user = User.new(params[:user])
    @user.password = (0...8).map{65.+(rand(25)).chr}.join #Random temp password
    @user.admin = params[:user][:admin]
    params[:user].delete :admin
    respond_to do |format|
      if @user.save
        @user.send_reset_password_instructions
        format.html { redirect_to :users, :notice => 'User was successfully updated.' }
        format.json { render :json => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])
    @user.admin = params[:user][:admin]
    params[:user].delete :admin
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to :users, :notice => 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
