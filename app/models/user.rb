class User < ActiveRecord::Base
  include ExpenseFormatter

  def process_message(message)
    message_action = determine_action(message)
    message_response = process_message_action(message_action, message)

    return message_response
  end

  def process_postback(postback)
    postback_response = process_postback_action(postback)
  end

  def determine_action(message)
    message_text = message['text']

    if message_text.split(' ')[0] =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/ && format_expense(message)
      return 'NEW_EXPENSE'
    elsif GREETING_MESSAGES.include?(message_text)
      return 'GREETING'
    elsif HELP_MESSAGES.include?(message_text)
      return 'HELP'
    elsif REPORTS_MESSAGES.include?(message_text)
      return 'REPORTS'
    elsif RESET_LOCATION_MESSAGES.include?(message_text)
      return 'RESET_LOCATION'
    else
      return 'UNRECOGNIZED'
    end
  end

  def process_message_action(message_action, message = nil)
    case message_action
      when 'GREETING'
        return {
          type: 'message',
          data: {
            text: 'Hi there.'
          }
        }
      when 'UNRECOGNIZED'
        return {
          type: 'message',
          data: {
            text: "I'm sorry, what was that?"
          }
        }
      when 'NEW_EXPENSE'
        self.state_data = format_expense(message).to_json

        return {
          type: 'button',
          data: {
            text: 'Correct?',
            buttons: [
              {
                type: 'postback',
                title: 'Yes',
                payload: 'NEW_EXPENSE_YES'
              },
              {
                type: 'postback',
                title: 'No',
                payload: 'NEW_EXPENSE_NO'
              }
            ]
          }
        }
    end
  end

  def process_postback_action(postback)
    if self.state == 'NEW_EXPENSE_CONFIRM'
      case postback['payload']
        when 'NEW_EXPENSE_YES'
          self.expenses.create(JSON.parse(self.state_data))
          self.state_data = nil
          self.state = nil
      end
    else
      return {
        type: 'message',
        data: {
          text: "I'm sorry, what was that?"
        }
      }
    end
  end
end
