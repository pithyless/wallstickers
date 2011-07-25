class UserSessionsController < ApplicationController
  skip_before_filter :require_login, :except => [:destroy]

  def create
    respond_to do |format|
      if @user = login(params[:username],params[:password])
        format.html { redirect_back_or_to('/', :notice => 'Login successfull.') }
        format.xml { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { redirect_back_or_to('/', :alert => 'Login failed.') }
        format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    logout
    redirect_to('/', :notice => 'Logged out!')
  end
end
