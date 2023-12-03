Rails.application.routes.draw do
  post :login , to: 'auth#login'
  resources :users, only: [:create, :update, :show]
  resources :invoices, only: [:create, :show, :update]
  resources :bets, only: [:create, :show, :update]
  get :pay_invoice, to: 'bets#pay_invoice'
end
