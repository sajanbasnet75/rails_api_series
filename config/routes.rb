# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users
      post 'login', to: 'sessions#login'

      #change password
      patch 'change_password', to: 'users#change_password'
    end
  end
end
