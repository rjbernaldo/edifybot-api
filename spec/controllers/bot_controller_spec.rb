require 'rails_helper'

RSpec.describe BotController do
  describe 'GET#verify_token' do
    context 'when correct token is received' do
      it 'should return 200' do
        params = {
          'hub.mode' => '',
          'hub.challenge' => '',
          'hub.verify_token' => 'correct_token',
          format: :json
        }

        get :verify_token, params

        expect(response.status).to eq(200)
      end
    end

    context 'when invalid token is received' do
      it 'should return 404 do' do
        params = {
          'hub.mode' => '',
          'hub.challenge' => '',
          'hub.verify_token' => 'incorrect_token',
          format: :json
        }

        get :verify_token, params

        expect(response.status).to eq(404)
      end
    end
  end

  describe 'POST#receive_data' do
    context 'when user sends a message' do
      it 'should create a new user' do
        body = {
          sender_id: '123',
          name: '123',
          format: :json
        }

        post :receive_data, body

        expect(response.status).to eq(200)

        last_user = User.last

        expect(last_user.name).to eq('123')
        expect(last_user.sender_id).to eq('123')
      end
    end
  end
end
