Rails.application.routes.draw do

  # VERB PATH TO: CONTROLLER#ACTION
  root                 to: "pages#home"
  get "/about",        to: "pages#about"
  get "/testimonials", to: "pages#testimonials"
end
