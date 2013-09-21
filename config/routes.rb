PhoneTicket::Application.routes.draw do
  devise_for :users,
    only: [:confirmation],
    controllers: { confirmations: "confirmations" }
  get "/users/confirmed", to: "thankyou#page", defaults: { page: "user_confirmed" }
  get "/users/confirmation/sent", to: "thankyou#page", defaults: { page: "users_confirmation_sent" }

  namespace :api do
    resources :users, only: [:create] do
      put "me" => "users#update", on: :collection
      post "sessions", on: :collection
    end
    resources :movies, only: [:show, :index]
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  scope path: "mail_preview" do
    mount ConfirmationPreview => 'confirmation'
  end if Rails.env.development?

end
