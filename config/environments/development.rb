Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Asset digests allow you to set far-future HTTP expiration dates on all assets,
  # yet still be able to expire them through the digest params.
  config.assets.digest = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true
  GREETING_MESSAGES = ['hi', 'hello']
  HELP_MESSAGES = ['help']
  REPORT_MESSAGES = ['report']
  RESET_LOCATION_MESSAGES = ['reset location']
  FACEBOOK_GRAPH_URL = 'https://graph.facebook.com'
  FACEBOOK_PAGE_ACCESS_TOKEN = 'EAAINb8zUjRgBAJo2qR1IHB94ZBPF5LSxGUy28HMt0O3b2vKNC2L0VQMrxAq5sAoZCCe8iaEv76jTsbwJBacavjuJetTCSNXC0fxALk3khZB09DQwJXP08c7ZAyZAk9KpxDZAjl42np4i5b0xavJBV1ZBzLggY97MybbD2SJ57tjGwZDZD'

  GREETING_MESSAGE_RESPONSES = [
    'Hi there. 🤓',
    "What's up? 🙂"
  ]

  UNRECOGNIZED_RESPONSE = {
    type: 'message',
    data: {
      text: "I'm sorry, what was that? 😕"
    }
  }
  
  NEW_EXPENSE_ADDED_RESPONSE = [
    "New expense added. 👍"  
  ]
  
  EXPENSE_NOT_SAVED_RESPONSE = [
    "Expense not saved. 👌"
  ]
  
  HELP_RESPONSE = [
    'What can I help you with? ℹ️'
  ]
  
  HELP_NEW_EXPENSE_RESPONSE = "To record a new expense, send a message with the following format:\n\n<AMOUNT> <ITEM> #<CATEGORY>\n\neg: '99 chickenjoy #food'"
  RECORD_EXPENSE_TUTORIAL = "Record an expense by sending something like '99 chickenjoy #food', view your expenses by typing 'report', or ask for 'help'."
  HELP_SHOW_REPORT_RESPONSE = "To view your expenses, send 'report'"
end
