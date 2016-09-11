class BotController < ApplicationController
  before_filter :authorized_scope, :only => [:receive_data]

  def verify_token
    puts 'verify_token'
  end

  def receive_data
    puts 'receive_data'
  end

  private

  def authorized_scope
    sender_id = params[:sender_id]

    puts 'authorized_scope'

    # @user = User.where('facebook_id = ?', sender_id).take

    # unless @user
    #   @user = User.create(
    #     facebook_id: sender_id
    #   )
    # end
  end
end
