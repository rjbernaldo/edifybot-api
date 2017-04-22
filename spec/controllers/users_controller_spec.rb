require 'rails_helper'

RSpec.describe UsersController do
  describe '#show' do
    let (:user) { FactoryGirl.create(:user) }
    let (:access_key) { user.generate_access_key }
    
    context 'when access_key is valid' do
      it 'should return user in json response' do
        get :show, :access_key => access_key

        expect(response.body).to include('access_key')
      end
    end
    
    context 'when access_key is no longer valid' do
      it 'should return appropriate error message' do
        get :show, :access_key => access_key
        expect(response.body).to include('access_key')
        
        get :show, :access_key => access_key
        expect(response.body).to include('error')
      end
    end
  end
end
