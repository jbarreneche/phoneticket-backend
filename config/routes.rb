PhoneTicket::Application.routes.draw do
  devise_for :users,
    only: [:confirmation],
    controllers: { confirmations: "confirmations" }
  get "/users/confirmed", to: "thankyou#page", defaults: { page: "user_confirmed" }
  get "/users/confirmation/sent", to: "thankyou#page", defaults: { page: "users_confirmation_sent" }

  namespace :api do
    resources :users, only: [:create] do
      get "me" => "users#show", on: :collection
      put "me" => "users#update", on: :collection
      post "sessions", on: :collection
    end
    resources :reservations, only: [:destroy]
    resources :movies, only: [:show, :index]
    resources :theatres, only: [:show, :index]
    resources :shows, only: [:show]
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  scope path: "mail_preview" do
    mount ConfirmationPreview => 'confirmation'
  end if Rails.env.development?

end
