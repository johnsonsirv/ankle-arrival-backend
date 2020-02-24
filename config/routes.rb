Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  
  namespace :api do
    namespace :v1 do
      resources :doctors do
        get '/appointments', to: 'doctors#appointments'
        get '/appointments/:id', to: 'doctors#appointment'
      end

      resources :users do
        get '/appointments', to: 'users#appointments'
        get '/appointments/:id', to: 'users#appointment'
      end
      
      resources :appointments, only: [:create, :update]
    end
  end
end
