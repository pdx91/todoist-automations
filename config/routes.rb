Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}

  devise_scope :user do
    unauthenticated :user do
      root to: "authentications#new"
    end

    authenticated :user do
      # root to: "landings#show", as: :authenticated_route
    end

    # delete "sign_out", to: "devise/sessions#destroy", as: :destroy_user_session
  end

  mount Vocab::Engine, at: "/vocab-builder"
end
