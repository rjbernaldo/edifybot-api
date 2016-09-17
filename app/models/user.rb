class User < ActiveRecord::Base
  def process_message(message)
    message_action = decode_message(message)
    message_response = process_action(message_action)

    return message_response
  end

  def decode_message(message)
    message_text = message['text']

    if GREETING_MESSAGES.include?(message_text)
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

  def process_action message_action
    if message_action == 'GREETING'
      return 'Hi there.'
    elsif message_action == 'UNRECOGNIZED'
      return "I'm sorry, what was that?"
    end
  end
end
