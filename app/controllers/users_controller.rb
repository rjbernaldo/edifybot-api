class UsersController < ApplicationController
  def show
    @user = user_params[:id]
  end

  def update
    @user = user_params[:id]
    @user.update_attributes(user_params)
  end

  protected

  def user_params
    params.permit(:id)
  end
end
