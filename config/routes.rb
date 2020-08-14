Rails.application.routes.draw do
  devise_for :users
  root                  to: "pages#home"
  get  "/about",        to: "pages#about"
  get  "/testimonials", to: "pages#testimonials"

  resources :coaching_requests, only: [:new, :create]

  resources :chapters do
    resources :sections, only: [:new, :create]
  end

  #                           admin  admin
  resources :sections, only: [:edit, :update]

  namespace :course do
    root to: "dashboards#show"
    resources :sections, only: :show
    # /course/sections/1
  end
end
