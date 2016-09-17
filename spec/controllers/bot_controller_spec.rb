require 'rails_helper'

RSpec.describe BotController do
  describe 'GET#verify_token' do
    context 'when correct token is received' do
      it 'should return 200' do
        params = {
          'hub.mode' => '',
          'hub.challenge' => 'challenge',
          'hub.verify_token' => 'correct_token',
          format: :json
        }

        get :verify_token, params

        expect(response.status).to eq(200)
        expect(response.body).to eq('challenge')
      end
    end

    context 'when invalid token is received' do
      it 'should return 404 do' do
        params = {
          'hub.mode' => '',
          'hub.challenge' => 'challenge',
          'hub.verify_token' => 'incorrect_token',
          format: :json
        }

        get :verify_token, params

        expect(response.status).to eq(404)
        expect(response.body).to eq('NOT FOUND')
      end
    end
  end

  describe 'POST#receive_data' do
    let(:body) {
      {
        "object"=>"page",
        "entry"=>[
          {
            "id"=>"1802378443326126",
            "time"=>1474075416133,
            "messaging"=>[
              {
                "sender"=>{
                  "id"=>"950498005077644"
                },
                "recipient"=>{
                  "id"=>"1802378443326126"
                },
                "timestamp"=>1474075304229,
                "message"=>{
                  "mid"=>"mid.1474075304191:1c03bf362eb135fc73",
                  "seq"=>2296,
                  "text"=>"test"
                }
              }
            ]
          }
        ],
        "bot"=>{
          "object"=>"page",
          "entry"=>[
            {
              "id"=>"1802378443326126",
              "time"=>1474075416133,
              "messaging"=>[
                {
                  "sender"=>{
                    "id"=>"950498005077644"
                  },
                  "recipient"=>{
                    "id"=>"1802378443326126"
                  },
                  "timestamp"=>1474075304229,
                  "message"=>{
                    "mid"=>"mid.1474075304191:1c03bf362eb135fc73",
                    "seq"=>2296,
                    "text"=>"test"
                  }
                }
              ]
            }
          ]
        }
      }
    }

    context 'when user sends a message' do
      before do
        stub_request(:post, "#{FACEBOOK_GRAPH_URL}/v2.6/me/messages?access_token=#{FACEBOOK_PAGE_ACCESS_TOKEN}")
          .to_return(body: 'OK')

        stub_request(:get, "#{FACEBOOK_GRAPH_URL}/v2.6/950498005077644?fields=first_name,last_name,profile_pic,locale,timezone,gender&access_token=#{FACEBOOK_PAGE_ACCESS_TOKEN}")
          .to_return(body: {
            first_name: 'test_firstname',
            last_name: 'test_lastname',
            profile_pic: 'profilepic.com',
            locale: '100',
            timezone: '100',
            gender: 'male'
          }.to_json)
      end
      
      it 'should create a new user' do
        post :receive_data, body

        expect(response.status).to eq(200)

        last_user = User.last

        expect(last_user.sender_id).to eq('950498005077644')
        expect(last_user.first_name).to eq('test_firstname')
        expect(last_user.last_name).to eq('test_lastname')
        expect(last_user.profile_pic).to eq('profilepic.com')
        expect(last_user.locale).to eq('100')
        expect(last_user.timezone).to eq('100')
        expect(last_user.gender).to eq('male')
      end
    end
  end
end
