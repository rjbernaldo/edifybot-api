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
      
      return if messages.nil?
        
      messages.each do |message|
        sender_id = message['sender']['id']
        message_body = message['message']
        postback_body = message['postback']

        user = User.where('sender_id = ?', sender_id).take

        unless user
          body = JSON.parse(retrieve_sender_details(sender_id).body)
          user = User.create(
            sender_id: sender_id,
            first_name: body['first_name'],
            last_name: body['last_name'],
            profile_pic: body['profile_pic'],
            locale: body['locale'],
            timezone: body['timezone'],
            gender: body['gender'],
            new_user: true
          )
        end

        if user[:new_user]
          message_response = user.process_new_user
          send_to_facebook(sender_id, message_response)
        elsif message_body
          message_response = user.process_message(message_body)
          send_to_facebook(sender_id, message_response)
        elsif postback_body
          postback_response = user.process_postback(postback_body)
          send_to_facebook(sender_id, postback_response)
        end
      end
    end
  end

  def decode_data body
    if body['bot']
      return body['bot']['entry']
    end
  end

  def retrieve_sender_details(sender_id)
    HTTParty.get(
      "#{FACEBOOK_GRAPH_URL}/v2.6/#{sender_id}?fields=first_name,last_name,profile_pic,locale,timezone,gender&access_token=#{FACEBOOK_PAGE_ACCESS_TOKEN}",
    )
  end

  def send_to_facebook(sender_id, message_response)
    headers = { 'Content-Type' => 'application/json' }

    case message_response[:type]
      when 'message'
        body = {
          recipient: {
            id: sender_id
          },
          message: {
            text: message_response[:data][:text]
          }
        }.to_json
      when 'button'
        body = {
          recipient: {
            id: sender_id
          },
          message: {
            attachment: {
              type: 'template',
              payload: {
                template_type: message_response[:type],
                text: message_response[:data][:text],
                buttons: message_response[:data][:buttons]
              }
            }
          }
        }.to_json
      when 'generic'
        body = {
          recipient: {
            id: sender_id
          },
          message: {
            attachment: {
              type: 'template',
              payload: {
                template_type: message_response[:type],
                elements: message_response[:elements]
              }
            }
          }
        }.to_json
    end

    HTTParty.post(
      "#{FACEBOOK_GRAPH_URL}/v2.6/me/messages?access_token=#{FACEBOOK_PAGE_ACCESS_TOKEN}",
      headers: headers,
      body: body
    )
  end
end
