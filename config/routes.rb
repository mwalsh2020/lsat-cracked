Rails.application.routes.draw do
  root                  to: "pages#home"
  get  "/about",        to: "pages#about"
  get  "/testimonials", to: "pages#testimonials"

  get  "/coaching",     to: "coaching_requests#new"
  post "/coaching",     to: "coaching_requests#create"
end
