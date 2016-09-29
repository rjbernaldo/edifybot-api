require 'rails_helper'

RSpec.describe ExpensesController do
  describe '#search' do
    context 'when only query is present' do
      let (:expense1) { FactoryGirl.create(:expense, item: 'some item test') }
      let (:expense2) { FactoryGirl.create(:expense, item: 'test') }
      let (:expense3) { FactoryGirl.create(:expense, item: 'factory') }
      let (:user) { FactoryGirl.create(:user, sender_id: 123, expenses: [expense1, expense2, expense3]) }

      it 'should only return the expenses that match that query' do
        get :search, :sender_id => user.sender_id, q: 'test'
        expect(response.body).to eq([expense1, expense2].to_json)
      end
    end

    context 'when both dates are present' do
      let (:to_date) { Chronic.parse('1/15/2015 3pm')}
      let (:expense1) { FactoryGirl.create(:expense, item: 'some item test', created_at: to_date) }
      let (:expense2) { FactoryGirl.create(:expense, item: 'test') }
      let (:user) { FactoryGirl.create(:user, sender_id: 123, expenses: [expense1, expense2]) }

      it 'should only return the expenses that are created after' do
        get :search, :sender_id => user.sender_id, from: '1/20/2015', to: '1/25/2015'
        expect(response.body).to eq([].to_json)

        get :search, :sender_id => user.sender_id, from: '1/15/2015', to: '1/16/2015'
        expect(response.body).to eq([expense1].to_json)
      end
    end
  end

  describe '#index' do
    let (:expense) { FactoryGirl.create(:expense) }
    let (:user) { FactoryGirl.create(:user, sender_id: 123, expenses: [expense]) }

    it 'should return expenses for that user' do
      get :index, :sender_id => user.sender_id

      expect(response.body).to eq([expense].to_json)
    end
  end

  describe '#show' do
    let (:expense) { FactoryGirl.create(:expense) }
    let (:user) { FactoryGirl.create(:user, sender_id: 123, expenses: [expense]) }

    it 'should return specific expense for that user' do
      get :show, :sender_id => user.sender_id, :id => expense.id

      expect(response.body).to eq(expense.to_json)
    end
  end

  describe '#destroy' do
    let (:expense) { FactoryGirl.create(:expense) }
    let (:user) { FactoryGirl.create(:user, sender_id: 123, expenses: [expense]) }

    it 'should return specific expense for that user' do
      delete :destroy, :sender_id => user.sender_id, :id => expense.id

      expect(response.body).to eq(expense.to_json)
    end
  end
end
