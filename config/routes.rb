Rails.application.routes.draw do
  get 'packets/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, format: 'json' do
    namespace :v1 do
      resources :net_packets, only: [:index]
    end
  end
end
