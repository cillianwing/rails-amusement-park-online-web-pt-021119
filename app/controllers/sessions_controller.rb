class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(name: params[:user][:name])
    if @user
      return redirect_to(controller: 'sessions', action: 'new') unless @user.try(:authenticate, params[:user][:password])
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      redirect_to(controller: 'users', action: 'new')
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to '/'
  end
end
