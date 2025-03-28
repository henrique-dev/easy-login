Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  get 'service-worker' => 'rails/pwa#service_worker', as: :pwa_service_worker
  get 'manifest' => 'rails/pwa#manifest', as: :pwa_manifest

  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'
  get '/sign_up', to: 'user_registrations#new'
  post '/sign_up', to: 'user_registrations#create'
  get '/sign_out', to: 'sessions#destroy'
  get '/home', to: 'home#show'
end
