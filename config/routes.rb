Rails.application.routes.draw do
  devise_for :users
  root                  to: "pages#home"
  get  "/about",        to: "pages#about"
  get  "/testimonials", to: "pages#testimonials"
  resources :coaching_requests, only: [:new, :create]

  namespace :admin do
    root to: "dashboards#show"
    resources :chapters, except: :show do
      resources :sections, only: [:new, :create]
    end

    resources :sections, only: [:edit, :update, :destroy] do
      resources :questions, only: [:new, :create, :index]
    end

    resources :questions, only: [:edit, :update, :destroy] do
      resources :answers, only: [:new, :create]
    end

    resources :users, only: :index
  end

  namespace :course do
    root to: "dashboards#show"
    resources :sections, only: :show do
      resources :quizzes, only: :create
    end
    resources :quizzes, only: [] do
      resources :sessions, only: :create, controller: "quiz/sessions"
    end
  end

  namespace :attachment do
    resources :youtube_videos, only: :show
  end
end
