Rails.application.routes.draw do
  root                  to: "pages#home"
  get  "/about",        to: "pages#about"
  get  "/testimonials", to: "pages#testimonials"

  resources :coaching_requests, only: [:new, :create]
  resources :chapters
end
