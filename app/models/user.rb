class User < ActiveRecord::Base
  def process_message(message)
    message_action = determine_action(message)
    message_response = process_action(message_action, message)

    return message_response
  end

  def process_postback(postback)
    postback_response = process_postback_action(postback)
  end

  def determine_action(message)
    message_text = message['text']

    if message_text.split(' ')[0] =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/
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

  def process_action(message_action, message = nil)
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

  def format_expense(message)
    return {
      amount: parse_amount(message),
      item: parse_item(message),
      location: parse_location(message),
      category: parse_category(message)
    }
  end

  private

  def parse_amount(message)
    text = message['text']

    return text.split(' ')[0]
  end

  def parse_item(message)
    text = message['text']

    parsed_text = text.split(' ')
    parsed_text.shift
    text = parsed_text.join(' ')

    location_index = text.index('@')
    category_index = text.index('#')

    if location_index != nil && category_index != nil
      if location_index < category_index
        index = location_index
      else
        index = category_index
      end
    elsif location_index != nil && category_index == nil
      index = location_index
    elsif location_index == nil && category_index != nil
      index = category_index
    else
      index = text.length
    end

    return text.slice(0, index).squish
  end

  def parse_location(message)
    text = message['text']

    location_index = text.index('@')
    category_index = text.index('#')

    if location_index != nil && category_index != nil
      if location_index < category_index
        index = category_index - 1
      else
        index = text.length
      end
    elsif location_index != nil && category_index == nil
      index = text.length
    elsif location_index == nil
      return nil
    end

    return text.slice(location_index + 1, index - location_index - 1)
  end

  def parse_category(message)
    text = message['text']

    location_index = text.index('@')
    category_index = text.index('#')

    if location_index != nil && category_index != nil
      if category_index < location_index
        index = location_index - 1
      else
        index = text.length
      end
    elsif category_index != nil && location_index == nil
      index = text.length
    elsif category_index == nil
      return nil
    end

    return text.slice(category_index + 1, index - category_index - 1)
  end
end
