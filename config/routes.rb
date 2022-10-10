# frozen_string_literal: true

Rails.application.routes.draw do
  mount_devise_token_auth_for "User", at: "users", controllers: {
    registrations: "users/registrations",
    passwords: "users/passwords",
  }
  devise_scope :user do
    post "users/sign_up" => "users/registrations#create"
  end
  resources :otp, only: [:create] do
    collection do
      post "verify"
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
