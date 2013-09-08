PhoneTicket::Application.routes.draw do
  devise_for :users,
    only: [:confirmation],
    controllers: { confirmations: "confirmations" }
  get "/users/confirmed", to: "thankyou#page", defaults: { page: "user_confirmed" }

  namespace :api do
    resources :users, only: [:create] do
      post "sessions", on: :collection
    end
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
