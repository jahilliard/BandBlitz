class UsersController < ApplicationController
  before_action :check_login

  def new
  end

  def edit
  	current_user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to( home_path, :notice => 'User was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @user = current_user
    if @user.update_attributes(user_params)
      redirect_to(home_path, :notice => 'User was successfully updated.')
    else
      render :action => "edit"
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :role, :band_id, :active)
  end

end