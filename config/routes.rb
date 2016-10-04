Rails.application.routes.draw do
  get 'bot/webhook' => 'bot#verify_token'
  post 'bot/webhook' => 'bot#receive_data'

  get 'users/:sender_id' => 'users#show'

  get 'users/:sender_id/search' => 'expenses#search'
  get 'users/:sender_id/expenses' => 'expenses#index'
  get 'users/:sender_id/expenses/:id' => 'expenses#show'
  # post 'users/:sender_id/expenses/:id' => 'expenses#create'
  patch 'users/:sender_id/expenses/:id' => 'expenses#update'
  delete 'users/:sender_id/expenses/:id' => 'expenses#destroy'
end
