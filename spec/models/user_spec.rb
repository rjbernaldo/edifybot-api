require 'rails_helper'

RSpec.describe User do
  let(:user) { create(:user) }
  let(:message_wrapper) {
    {
      "mid"=>"mid.1474075304191:1c03bf362eb135fc73",
      "seq"=>2296,
      "text"=>""
    }
  }

  describe '#determine_action' do
    describe 'GREETING' do
      context 'when message is "hi"' do
        it 'should respond with "GREETING"' do
          message = message_wrapper.dup
          message['text'] = 'hi'

          message_action = user.determine_action(message)
          expect(message_action).to eq('GREETING')
        end
      end

      context 'when message is different greeting' do
        it 'should be able to recognize them' do
          message = message_wrapper.dup
          message['text'] = 'hello'

          message_action = user.determine_action(message)
          expect(message_action).to eq('GREETING')
        end
      end
    end

    describe 'HELP' do
      context 'when message is help' do
        it 'should respond with "HELP"' do
          message = message_wrapper.dup
          message['text'] = 'help'

          message_action = user.determine_action(message)
          expect(message_action).to eq('HELP')
        end
      end

      context 'when message is reset location' do # TODO: Maybe payload?
        it 'should respond with "RESET_LOCATION"' do
          message = message_wrapper.dup
          message['text'] = 'reset location'

          message_action = user.determine_action(message)
          expect(message_action).to eq('RESET_LOCATION')
        end
      end
    end

    describe 'REPORTS' do
      context 'when message is reports' do
        it 'should respond with "REPORTS"' do
          message = message_wrapper.dup
          message['text'] = 'reports'

          message_action = user.determine_action(message)
          expect(message_action).to eq('REPORTS')
        end
      end
    end

    describe 'NEW EXPENSE' do
      context 'when message is a new expense' do
        it 'should respond with "NEW_EXPENSE"' do
          message = message_wrapper.dup
          message['text'] = '20 ramen @mesho #food'

          message_action = user.determine_action(message)
          expect(message_action).to eq('NEW_EXPENSE')
        end
      end
    end

    describe 'UNRECOGNIZED' do
      context 'when message is unrecognized' do
        it 'should respond with "UNRECOGNIZED"' do
          message = message_wrapper.dup
          message['text'] = 'asdjfkahsfkjads'

          message_action = user.determine_action(message)
          expect(message_action).to eq('UNRECOGNIZED')
        end
      end
    end
  end

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

  describe '#process_action' do
    context 'when action is "GREETING"' do
      it 'should respond with a greeting' do
        message_response = user.process_action('GREETING', nil)
        expect(message_response[:data][:text]).to eq('Hi there.')
      end
    end

    context 'when action is "UNRECOGNIZED"' do
      it 'should respond appropriately' do
        message_response = user.process_action('UNRECOGNIZED', nil)
        expect(message_response[:data][:text]).to eq("I'm sorry, what was that?")
      end
    end
  end

  describe '#process_postback_action' do
    context 'when action is "NEW_EXPENSE_YES"' do
      
    end
  end
end
