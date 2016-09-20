require 'rails_helper'

RSpec.describe ExpenseFormatter do
  let(:user) { create(:user) }
  let(:message_wrapper) {
    {
      "mid"=>"mid.1474075304191:1c03bf362eb135fc73",
      "seq"=>2296,
      "text"=>""
    }
  }

  describe '#format_expense' do
    context 'when message is valid' do
      it 'should return a formatted expense' do
        message = message_wrapper.dup
        message['text'] = '20 ramen @mensho #food'

        decoded_message = user.format_expense(message)
        expect(decoded_message[:amount]).to eq('20')
        expect(decoded_message[:item]).to eq('ramen')
        expect(decoded_message[:location]).to eq('mensho')
        expect(decoded_message[:category]).to eq('food')
      end
    end

    context 'when message has spaces' do
      it 'should return a formatted expense' do
        message = message_wrapper.dup
        message['text'] = '20 shoyu ramen @ramen underground #comfort food'

        decoded_message = user.format_expense(message)
        expect(decoded_message[:amount]).to eq('20')
        expect(decoded_message[:item]).to eq('shoyu ramen')
        expect(decoded_message[:location]).to eq('ramen underground')
        expect(decoded_message[:category]).to eq('comfort food')
      end
    end

    context 'when order is swapped' do
      it 'should return a formatted expense' do
        message = message_wrapper.dup
        message['text'] = '20 ramen #food @mensho'

        decoded_message = user.format_expense(message)
        expect(decoded_message[:amount]).to eq('20')
        expect(decoded_message[:item]).to eq('ramen')
        expect(decoded_message[:location]).to eq('mensho')
        expect(decoded_message[:category]).to eq('food')
      end
    end
  end
end
