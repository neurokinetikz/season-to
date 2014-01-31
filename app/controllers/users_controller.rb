class UsersController < ApplicationController
  before_filter :authenticate_user!
  
  def update
    current_user.update_attributes(params[:user])
    flash[:notice] = "Your profile was successfully updated"
    redirect_to profile_path
  end
end
