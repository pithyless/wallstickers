class UsersController < ApplicationController
  skip_before_filter :require_login, :only => [:new, :create]

  def profile
    @user = User.find_by_username(params[:username]) || not_found
  end

  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find_by_username(params[:username]) || not_found
  end

  def create
    @user = User.new(params[:user])
    @user.username = params[:username]
    @user.email = params[:email]

    if @user.save
      redirect_to(profile_path(@user), :notice => 'User was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @user = User.find_by_username(params[:username]) || not_found

    if @user.update_attributes(params[:user])
      redirect_to(profile_path(@user), :notice => 'User was successfully updated.')
    else
      render :action => "edit"
    end
  end
end