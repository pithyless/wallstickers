class ProfilesController < ApplicationController
  skip_before_filter :require_login, :only => [:new, :create]

  def profile
    @user = User.find_by_username!(params[:id])
    authorize! :read, @user
  end

  def edit
    @user = User.find_by_username!(params[:id])
    authorize! :update, @user
  end

  def update
    @user = User.find_by_username!(params[:id])
    authorize! :update, @user

    if @user.update_attributes(params[:user])
      flash[:notice] = 'Profile successfully updated.'
      redirect_to profile_path(@user)
    else
      render :action => "edit"
    end
  end

  def new
    authorize! :create, User
    @user = User.new

    render 'register_user'
  end

  def create
    authorize! :create, User
    @user = User.new(params[:user])
    @user.email = params[:user][:email]
    @user.username = User.generate_unique_username # TODO: race condition may raise exception

    if @user.save
      flash[:notice] = 'Registration complete.'
      redirect_to '/'
    else
      render :action => 'register_user'
    end
  end

  def register_artist
    @user = User.find_by_username!(params[:id])
    authorize! :register_artist, @user

    @registration = ArtistRegistration.new(@user)
  end

  def create_artist
    @user = User.find_by_username!(params[:id])
    authorize! :register_artist, @user

    @registration = ArtistRegistration.new(@user, params)

    if @registration.save
      redirect_to profile_path(@user)
    else
      render :action => 'register_artist'
    end
  end
end
