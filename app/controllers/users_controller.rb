class UsersController < ApplicationController
  before_filter :authenticate_user!
  
  def update
    if current_user.update(params[:user])
      # Sign in the user by passing validation in case his password changed
      sign_in current_user, :bypass => true
      flash[:notice] = "Your account was successfully updated"
      redirect_to account_path
    else
      render "edit"
    end
  end
end
