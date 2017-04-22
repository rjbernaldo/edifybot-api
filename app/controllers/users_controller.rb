class UsersController < ApplicationController
  include ResponseHelper
  
  def show
    user = User.find_by_access_key(params[:access_key])
    
    return invalid_access_key unless user && user.access_key_valid?
    
    render :json => user.to_json
  end
end
