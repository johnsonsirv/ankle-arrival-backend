Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  
  namespace :api do
    namespace :v1 do
      resources :doctors do
        get '/appointments', to: 'doctors#appointments'
        get '/appointments/:id', to: 'doctors#appointment'
      end

      
      get '/users/appointments', to: 'users#appointments'
      get '/users/appointments/:id', to: 'users#appointment'
      
      
      resources :appointments, only: [:create, :update, :destroy]
      
      # auth
      post '/users/signup', to: 'users#create'
      post '/auth/login', to: 'authentication#create'
    end
  end
end
