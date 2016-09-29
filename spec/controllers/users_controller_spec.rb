require 'rails_helper'

RSpec.describe UsersController do
  describe '#show' do
    context 'when sender_id is passed as a param' do
      let (:user) { FactoryGirl.create(:user, sender_id: 123) }

      it 'should return user in json response' do
        get :show, :sender_id => user.sender_id

        expect(response.body).to eq(user.to_json)
      end
    end
  end
end
