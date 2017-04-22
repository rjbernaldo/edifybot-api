Rails.application.routes.draw do
  # facebook api
  get 'bot/webhook' => 'bot#verify_token'
  post 'bot/webhook' => 'bot#receive_data'

  # report
  get 'users/:access_key' => 'users#show'
  
  # expense list
  # get 'users/:access_key/search' => 'expenses#search'
  get 'users/:access_key/expenses' => 'expenses#index'
  
  # expense
  get 'users/:access_key/expenses/:id' => 'expenses#show'
  patch 'users/:access_key/expenses/:id' => 'expenses#update'
  delete 'users/:access_key/expenses/:id' => 'expenses#destroy'
end