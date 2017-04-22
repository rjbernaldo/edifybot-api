require 'rails_helper'

RSpec.describe ExpensesController do
  # describe '#search' do
  #   context 'when only query is present' do
  #     let (:expense1) { FactoryGirl.create(:expense, item: 'some item test') }
  #     let (:expense2) { FactoryGirl.create(:expense, item: 'test') }
  #     let (:expense3) { FactoryGirl.create(:expense, item: 'factory') }
  #     let (:user) { FactoryGirl.create(:user, sender_id: 123, expenses: [expense1, expense2, expense3]) }
  # 
  #     it 'should only return the expenses that match that query' do
  #       
  #       get :search, :access_key => user.generate_access_key, q: 'test'
  #       expect(response.body).to eq([expense1, expense2].to_json)
  #     end
  #   end
  # 
  #   context 'when both dates are present' do
  #     let (:to_date) { Chronic.parse('1/15/2015 3pm')}
  #     let (:expense1) { FactoryGirl.create(:expense, item: 'some item test', created_at: to_date) }
  #     let (:expense2) { FactoryGirl.create(:expense, item: 'test') }
  #     let (:user) { FactoryGirl.create(:user, sender_id: 123, expenses: [expense1, expense2]) }
  # 
  #     it 'should only return the expenses that are created after' do
  #       get :search, :access_key => user.generate_access_key, from: '1/20/2015', to: '1/25/2015'
  #       expect(response.body).to eq([].to_json)
  # 
  #       get :search, :access_key => user.generate_access_key, from: '1/15/2015', to: '1/16/2015'
  #       expect(response.body).to eq([expense1].to_json)
  #     end
  #   end
  # end

  describe '#index' do
    let (:expense) { FactoryGirl.create(:expense) }
    let (:user) { FactoryGirl.create(:user, expenses: [expense]) }

    context 'when access_key is valid' do
      it 'should return expenses for that user' do
        get :index, :access_key => user.generate_access_key

        expect(response.body).to eq([expense].to_json)
      end
    end
    
    context 'when access_key is invalid' do
      it 'should return appropriate error' do
        get :index, :access_key => '123'
        
        expect(response.body).to include('error')
      end
    end
  end

  describe '#show' do
    let (:expense) { FactoryGirl.create(:expense) }
    let (:user) { FactoryGirl.create(:user, expenses: [expense]) }

    context 'when access_key is valid' do
      it 'should return specific expense for that user' do
        get :show, :access_key => user.generate_access_key, :id => expense.id

        expect(response.body).to eq(expense.to_json)
      end
    end
    
    context 'when access_key is invalid' do
      it 'should return appropriate error' do
        get :show, :access_key => '123', :id => expense.id

        expect(response.body).to include('error')
      end
    end
  end

  describe '#destroy' do
    let (:expense) { FactoryGirl.create(:expense) }
    let (:user) { FactoryGirl.create(:user, expenses: [expense]) }

    context 'when access_key is valid' do
      it 'should return specific expense for that user' do
        delete :destroy, :access_key => user.generate_access_key, :id => expense.id

        expect(response.body).to eq(expense.to_json)
      end
    end
    
    context 'when access_key is invalid' do
      it 'should return appropriate error' do
        delete :destroy, :access_key => '123', :id => expense.id

        expect(response.body).to include('error')
      end
    end
  end
end
