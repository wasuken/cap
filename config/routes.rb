Rails.application.routes.draw do
  devise_for :users, :controllers => {
               :registrations => 'users/registrations',
               :sessions => 'users/sessions'
             }

  devise_scope :user do
    get "user/:id", :to => "users/registrations#detail"
    get "signup", :to => "users/registrations#new"
    get "login", :to => "users/sessions#new"
    get "logout", :to => "users/sessions#destroy"
  end
  get "/", to: 'net_packets#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, format: 'json' do
    namespace :v1 do
      resources :net_packets, only: [:index, :store]
    end
  end
  get '*path', to: 'homes#redirect_to_root'
end
