class BotController < ApplicationController
  def verify_token
    if params['hub.verify_token'] == 'correct_token'
      render text: params['hub.challenge'], status: 200
    else
      render text: 'NOT FOUND', status: 404
    end
  end

  def receive_data
    render text: 'OK', status: 200

    entries = decode_data(params)
    entries.each do |entry|
      messages = entry['messaging']
      messages.each do |message|
        sender_id = message['sender']['id']
        message_body = message['message']

        user = User.where('sender_id = ?', sender_id).take || User.create(sender_id: sender_id)

        #unless user.name do
        #  sender_details = retrieve_sender_details(sender_id)

        #  user.update_attributes(sender_details)
        #  user.save
        #end

        message_response = user.process_message(message_body)
        send_to_facebook(sender_id, message_response)
      end
    end
  end

  def decode_data body
    if body['bot']
      return body['bot']['entry']
    end
  end

  #def retrieve_sender_details(sender_id)
  #end

  def send_to_facebook(sender_id, message_response)
    headers = { 'Content-Type' => 'application/json' }
    body = {
      recipient: {
        id: sender_id
      },
      message: {
        text: message_response
      }
    }.to_json

    HTTParty.post(
      "#{FACEBOOK_GRAPH_URL}/v2.6/me/messages?access_token=#{FACEBOOK_PAGE_ACCESS_TOKEN}",
      headers: headers,
      body: body
    )
  end
end
