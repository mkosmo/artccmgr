# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users,
             controllers: { omniauth_callbacks: "omniauth_callbacks" },
             skip: [:sessions]

  # Manually manage sign out path due to the lack of database authenticatable
  devise_scope :user do
    delete "logout" => "devise/sessions#destroy"
  end

  root to: "home#index"

  namespace :training do
    resource  :profile, only: [:show]
    resources :sessions
  end
end
