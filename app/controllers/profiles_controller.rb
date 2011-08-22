class ProfilesController < ApplicationController
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
end
