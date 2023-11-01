Rails.application.routes.draw do
  resources :games, only: [:index] do
    get :index_game_users, to: 'games#index_game_users'
  end
  resources :users, param: :npub, only: [:create, :update, :show]
  get :add_user_to_game, to: 'users#add_user_to_game'
  resources :invoices, only: [:create, :show, :update]
  get :pay_invoice, to: 'invoices#pay_invoice'
end
