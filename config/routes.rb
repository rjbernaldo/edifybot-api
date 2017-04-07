Rails.application.routes.draw do
  # facebook api
  get 'bot/webhook' => 'bot#verify_token'
  post 'bot/webhook' => 'bot#receive_data'

  # report
  get 'users/:sender_id' => 'users#show'
  
  # expense list
  get 'users/:sender_id/search' => 'expenses#search'
  get 'users/:sender_id/expenses' => 'expenses#index'
  
  # expense
  get 'users/:sender_id/expenses/:id' => 'expenses#show'
  patch 'users/:sender_id/expenses/:id' => 'expenses#update'
  delete 'users/:sender_id/expenses/:id' => 'expenses#destroy'
end