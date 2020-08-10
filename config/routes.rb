Rails.application.routes.draw do

  # VERB PATH TO: CONTROLLER#ACTION
  get "/", to: "pages#home"
end
