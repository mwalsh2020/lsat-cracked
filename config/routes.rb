Rails.application.routes.draw do

  # VERB PATH TO: CONTROLLER#ACTION
  root          to: "pages#home"
  get "/about", to: "pages#about"
end
