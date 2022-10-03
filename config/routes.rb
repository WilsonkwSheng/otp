Rails.application.routes.draw do
  resources :otp, only: [:create] do
    collection do
      post 'verify'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
