Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # API endpoints
  namespace :api do
    namespace :v1 do
      resources :books, except: :update do
        member do
          patch :update
        end
      end

      resources :users, except: :update do
        member do
          patch :update
        end
      end

      resources :borrowings, except: [ :update ] do
        member do
          patch :update
        end

        get :return_book
      end

      resources :user_confirmations, only: :show, param: :confirmation_token
      resources :password_resets, only: [ :show, :create, :update ], param: :reset_token

      resources :access_tokens, only: :create do
        delete "/", action: :destroy, on: :collection
      end

      get "/search/:text", to: "search#index"
    end
  end

  # Defines the root path route ("/")
  # root "posts#index"
end
