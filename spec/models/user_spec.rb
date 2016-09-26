require 'rails_helper'

RSpec.describe User do
  let(:user) { create(:user) }
  let(:message_wrapper) {
    {
      "mid" => "mid.1474075304191:1c03bf362eb135fc73",
      "seq" => 2296,
      "text" => ""
    }
  }
  let(:postback_wrapper) {
    { 'payload' => "" }
  }

  describe '#process_new_user' do
    it 'should respond with intro' do
      message_response = user.process_new_user
      expect(message_response[:data][:text]).to eq("Hi #{user[:first_name]}. Please select your currency so we can get started.")
      expect(message_response[:data][:buttons][0][:title]).to eq('Peso (₱)')
      expect(message_response[:data][:buttons][0][:payload]).to eq('NEW_USER_PESO')
    end
  end

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
      
      context 'when message is capitalized' do
        it 'should respond with "GREETING"' do
          message = message_wrapper.dup
          message['text'] = 'Hi'

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
    end

    describe 'REPORTS' do
      context 'when message is report' do
        it 'should respond with "REPORT"' do
          message = message_wrapper.dup
          message['text'] = 'report'

          message_action = user.determine_action(message)
          expect(message_action).to eq('REPORTS')
        end
      end
    end

    describe 'NEW EXPENSE' do
      context 'when message is a new expense' do
        context 'when the expense formatting is correct' do
          it 'should respond with "NEW_EXPENSE"' do
            message = message_wrapper.dup
            message['text'] = '20 ramen @mesho #food'

            message_action = user.determine_action(message)
            expect(message_action).to eq('NEW_EXPENSE')
          end
        end

        context 'when the expense formatting is incorrect' do
          it 'should respond with "UNRECOGNIZED"' do
            message = message_wrapper.dup
            message['text'] = '20 @mensho ramen #food'

            message_action = user.determine_action(message)
            expect(message_action).to eq('UNRECOGNIZED')
          end
        end
      end
    end

    describe 'HELP' do
      context 'when message is asking for help' do
        it 'should respond with "HELP"' do
          message = message_wrapper.dup
          message['text'] = 'help'

          message_action = user.determine_action(message)
          expect(message_action).to eq('HELP')
        end
      end
    end

    describe 'WAITING_FOR_CONFIRMATION' do
      context 'when we are still waiting for a confirmation postback' do
        it 'should respond with the last message' do
          user.state = 'NEW_EXPENSE_CONFIRM'
          message = message_wrapper.dup
          message['text'] = 'something else'
          
          message_action = user.determine_action(message)
          expect(message_action).to eq('WAITING_FOR_CONFIRMATION')
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

  describe '#process_message_action' do
    context 'when action is "GREETING"' do
      it 'should respond with a greeting' do
        message_response = user.process_message_action('GREETING', nil)
        expect(GREETING_MESSAGE_RESPONSES.include?(message_response[:data][:text])).to eq(true)
      end
    end
    
    context 'when action is "WAITING_FOR_CONFIRMATION"' do
      it 'should respond with the last message' do
        user.last_response = {
          type: 'button',
          data: {
            buttons: [
              {
                type: 'postback'
              }
            ]
          }
        }
        
        message_response = user.process_message_action('WAITING_FOR_CONFIRMATION', nil)
        expect(message_response[:type]).to eq('button')
        expect(message_response[:data][:buttons][0][:type]).to eq('postback')
      end
    end

    context 'when action is "UNRECOGNIZED"' do
      it 'should respond appropriately' do
        message_response = user.process_message_action('UNRECOGNIZED', nil)
        expect(message_response[:data][:text]).to eq(UNRECOGNIZED_RESPONSE[:data][:text])
      end
    end

    context 'when action is "NEW_EXPENSE"' do
      it 'should respond with buttons' do
        message_response = user.process_message_action('NEW_EXPENSE', { 'text' => '20 ramen @mensho #food' })

        expect(message_response[:data][:text]).to eq("💵 #{user.currency_symbol}20\n📦 ramen\n📍 mensho\n📂 food\n\nIs this correct? 🤔")
        expect(message_response[:data][:buttons][0][:payload]).to eq('NEW_EXPENSE_YES')
        expect(message_response[:data][:buttons][1][:payload]).to eq('NEW_EXPENSE_NO')
      end
    end

    context 'when action is "REPORTS"' do
      let(:expense) { create(:expense, amount: 20) }

      it "should respond with a report of the user's expenses" do
        user.expenses << expense
        message_response = user.process_message_action('REPORTS')

        expect(message_response[:data][:text]).to eq("Daily: #{user.currency_symbol}20\nWeekly: #{user.currency_symbol}20\nMonthly: #{user.currency_symbol}20")
      end
    end

    context 'when action is "HELP"' do
      it 'should respond with buttons' do
        message_response = user.process_message_action('HELP')

        expect(HELP_RESPONSE.include?(message_response[:data][:text])).to eq(true)
        expect(message_response[:data][:buttons][0][:payload]).to eq('HELP_NEW_EXPENSE')
        expect(message_response[:data][:buttons][1][:payload]).to eq('HELP_SHOW_REPORT')
      end
    end
  end

  describe '#process_postback_action' do
    context 'when action is "NEW_EXPENSE_YES"' do
      let(:user) { create(:user) }

      it 'should add a new expense for the user' do
        postback = postback_wrapper.dup
        postback['payload'] = 'NEW_EXPENSE_YES'

        user.update_attributes(state: 'NEW_EXPENSE_CONFIRM', state_data: "{}")
        postback_response = user.process_postback_action(postback)
        expect(NEW_EXPENSE_ADDED_RESPONSE.include?(postback_response[:data][:text])).to eq(true)
      end
    end

    context 'when action is "NEW_EXPENSE_NO"' do
      let(:user) { create(:user) }

      it 'should not add a new expense for the user' do
        postback = postback_wrapper.dup
        postback['payload'] = 'NEW_EXPENSE_NO'

        user.update_attributes(state: 'NEW_EXPENSE_CONFIRM', state_data: "{}")
        postback_response = user.process_postback_action(postback)
        expect(EXPENSE_NOT_SAVED_RESPONSE.include?(postback_response[:data][:text])).to eq(true)
      end
    end

    context 'when action is "HELP_NEW_EXPENSE"' do
      it 'should respond with instructions on how to add an expense' do
        postback = postback_wrapper.dup
        postback['payload'] = 'HELP_NEW_EXPENSE'

        postback_response = user.process_postback_action(postback)
        expect(postback_response[:data][:text]).to eq("To record a new expense, send a message with the following format:\n\n<AMOUNT> <ITEM> @<LOCATION> #<CATEGORY>\n\neg: '99 Chickenjoy @Jollibee #Food'")
      end
    end

    context 'when action is "HELP_SHOW_REPORT"' do
      it 'should respond with instructions on how to show report' do
        postback = postback_wrapper.dup
        postback['payload'] = 'HELP_SHOW_REPORT'

        postback_response = user.process_postback_action(postback)
        expect(postback_response[:data][:text]).to eq("To view your expenses, send 'report'")
      end
    end

    context 'when interacting with a new user' do
      context 'when action is "NEW_USER_PESO"' do
        it 'should respond appropriately' do
          postback = postback_wrapper.dup
          postback['payload'] = 'NEW_USER_PESO'

          postback_response = user.process_postback_action(postback)
          expect(user.currency).to eq('Peso')
          expect(user.currency_symbol).to eq('₱')
          expect(postback_response[:data][:text]).to eq("I've set your currency to #{user.currency} (#{user.currency_symbol}), let's begin!\n\nTry recording an expense by sending something like '99 Chickenjoy @Jollibee #Food', view your expenses by typing 'report', or ask for 'help'.")
        end
      end
    end
  end
end
