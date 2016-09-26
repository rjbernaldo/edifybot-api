class User < ActiveRecord::Base
  include ExpenseFormatter

  serialize :last_response
  has_many :expenses

  def process_new_user
    self.new_user = false
    self.last_response = {
      type: 'button',
      data: {
        text: "Hi #{self.first_name}. Please select your currency so we can get started.",
        buttons: [
          {
            type: 'postback',
            title: 'Peso (₱)',
            payload: 'NEW_USER_PESO'
          }
        ]
      }
    }
    self.save
    
    return self.last_response
  end

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

    if self.state == 'NEW_EXPENSE_CONFIRM'
      return 'WAITING_FOR_CONFIRMATION'
    elsif message_text.split(' ')[0] =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/ && format_expense(message)
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
      when 'WAITING_FOR_CONFIRMATION'
        return self.last_response
      when 'GREETING'
        return {
          type: 'message',
          data: {
            text: GREETING_MESSAGE_RESPONSES.sample
          }
        }
      when 'UNRECOGNIZED'
        return UNRECOGNIZED_RESPONSE
      when 'NEW_EXPENSE'
        formatted_message = format_expense(message)
        self.state = 'NEW_EXPENSE_CONFIRM'
        self.state_data = formatted_message.to_json
        
        amount = formatted_message[:amount]
        item = formatted_message[:item]
        location = formatted_message[:location]
        category = formatted_message[:category]
        
        message_text = [
          "💵 #{amount}",
          "📦 #{item}"
        ]
        
        if location
          message_text.push("📍 #{location}")
        end
        
        if category
          message_text.push("📂 #{category}")
        end
        
        self.last_response = {
          type: 'button',
          data: {
            text: "#{message_text.join("\n")}\n\nIs this correct? 🤔",
            buttons: [
              {
                type: 'postback',
                title: 'Yes ✔️',
                payload: 'NEW_EXPENSE_YES'
              },
              {
                type: 'postback',
                title: 'No ❌',
                payload: 'NEW_EXPENSE_NO'
              }
            ]
          }
        }
        self.save
        
        return self.last_response
      when 'REPORTS'
        daily = generate_daily_report
        weekly = generate_weekly_report
        monthly = generate_monthly_report

        return {
          type: 'message',
          data: {
            text: "Daily: #{daily}\nWeekly: #{weekly}\nMonthly: #{monthly}"
          }
        }
      when 'HELP'
        return {
          type: 'button',
          data: {
            text: HELP_RESPONSE.sample,
            buttons: [
              {
                type: 'postback',
                title: 'Create a new expense',
                payload: 'HELP_NEW_EXPENSE'
              },
              {
                type: 'postback',
                title: 'View expense report',
                payload: 'HELP_SHOW_REPORT'
              }
            ]
          }
        }
    end
  end

  def process_postback_action(postback)
    case postback['payload']
      when 'NEW_EXPENSE_YES'
        if self.state == 'NEW_EXPENSE_CONFIRM'
          self.expenses << Expense.create(JSON.parse(self.state_data))
          self.last_response = nil
          self.state_data = nil
          self.state = nil
          self.save

          return {
            type: 'message',
            data: {
              text: NEW_EXPENSE_ADDED_RESPONSE.sample
            }
          }
        else
          return UNRECOGNIZED_RESPONSE.sample
        end
      when 'NEW_EXPENSE_NO'
        if self.state == 'NEW_EXPENSE_CONFIRM'
          self.last_response = nil
          self.state_data = nil
          self.state = nil
          self.save

          return {
            type: 'message',
            data: {
              text: EXPENSE_NOT_SAVED_RESPONSE.sample
            }
          }
        else
          return UNRECOGNIZED_RESPONSE
        end
      when 'HELP_NEW_EXPENSE'
        return {
          type: 'message',
          data: {
            text: "To record a new expense, send a message with the following format:\n\n<AMOUNT> <ITEM> @<LOCATION> #<CATEGORY>\n\neg: '99 Chickenjoy @Jollibee #Food'"
          }
        }
      when 'HELP_SHOW_REPORT'
        return {
          type: 'message',
          data: {
            text: "To view your expenses, send 'report'"
          }
        }
      when 'NEW_USER_PESO'
        self.last_response = nil
        self.currency = 'Peso'
        self.currency_symbol = '₱'
        self.save

        return {
          type: 'message',
          data: {
            text: "I've set your currency to #{self.currency} (#{self.currency_symbol}), let's begin!\n\nTry recording an expense by sending something like '99 Chickenjoy @Jollibee #Food', view your expenses by typing 'report', or ask for 'help'."
          }
        }
      else
        return UNRECOGNIZED_RESPONSE
    end
  end

  private

  def generate_daily_report
    self.expenses.where("created_at >= ?", Chronic.parse('today at 00:00')).inject(0) { |total, e| total + e.amount.to_i }
  end

  def generate_weekly_report
    self.expenses.where("created_at >= ?", Chronic.parse('this week at 00:00')).inject(0) { |total, e| total + e.amount.to_i }
  end

  def generate_monthly_report
    self.expenses.where("created_at >= ?", Chronic.parse('this month at 00:00')).inject(0) { |total, e| total + e.amount.to_i }
  end
end
