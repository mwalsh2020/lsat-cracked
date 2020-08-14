Rails.application.routes.draw do
  devise_for :users
  root                  to: "pages#home"
  get  "/about",        to: "pages#about"
  get  "/testimonials", to: "pages#testimonials"
  resources :coaching_requests, only: [:new, :create]

  namespace :admin do
    resources :chapters, except: :show do
      resources :sections, only: [:new, :create]
    end

    resources :sections, only: [:edit, :update] do
      resources :questions, only: [:new, :create]
    end
  end

  namespace :course do
    root to: "dashboards#show"
    resources :sections, only: :show
  end
end
