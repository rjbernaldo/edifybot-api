class BotController < ApplicationController
  before_filter :authorized_scope, :only => [:receive_data]

  def verify_token
    if params['hub.verify_token'] == 'correct_token'
      render json: {}, status: 200
    else
      render json: {}, status: 404
    end
  end

  def receive_data
    render json: {}, status: 200
  end

  def decode_data body
  end

  private

  def authorized_scope
    user = User.where('sender_id = ?', params[:sender_id]).take

    unless user
      user = User.create(
        sender_id: params[:sender_id],
        name: params[:name]
      )
    end

    @user = user
  end
end
