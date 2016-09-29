class UsersController < ApplicationController
  def show
    @user = User.find_by_sender_id(params[:sender_id])
    render :json => @user.to_json
  end
end
