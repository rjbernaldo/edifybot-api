class User < ActiveRecord::Base
  include ExpenseFormatter

  has_many :expenses

  def process_new_user
    self.new_user = false
    self.save

    return {
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
            text: GREETING_MESSAGE_RESPONSES.sample
          }
        }
      when 'UNRECOGNIZED'
        return UNRECOGNIZED_RESPONSE
      when 'NEW_EXPENSE'
        self.state = 'NEW_EXPENSE_CONFIRM'
        self.state_data = format_expense(message).to_json
        self.save

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
            text: 'What can I help you with?',
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
          self.state_data = nil
          self.state = nil
          self.save

          return {
            type: 'message',
            data: {
              text: "New expense added."
            }
          }
        else
          return UNRECOGNIZED_RESPONSE
        end
      when 'NEW_EXPENSE_NO'
        if self.state == 'NEW_EXPENSE_CONFIRM'
          self.state_data = nil
          self.state = nil
          self.save

          return {
            type: 'message',
            data: {
              text: "Expense not saved."
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
