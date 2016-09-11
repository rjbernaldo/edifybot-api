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
  end
end
