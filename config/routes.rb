Rails.application.routes.draw do
  devise_for :users
  root                  to: "course/dashboards#show"
  get  "/about",        to: "pages#about"
  get  "/testimonials", to: "pages#testimonials"
  get "/guest/sessions", to: "pages#home"

  require "sidekiq/web"
  authenticate :user, ->(user) {
                        user.admin?
                      } do
    mount Sidekiq::Web => "/sidekiq"

    namespace :admin do
      resources :articles
      resources :chapters
      resources :sections
      resources :questions do
        resources :answers
      end
      resources :answers
      resources :tags
      resources :users, except: [:create, :new]
      resources :quizzes
      resources :quiz_questions
      resources :products
      resources :orders

      root to: "chapters#index"
    end
  end

  resources :coaching_requests,
            only: [:new, :create]
  resources :mail_leads, only: [:create]
  resources :products, only: [:index]
  resources :orders, only: [:create, :show] do
    resources :payments, only: :new
  end

  namespace :guest do
    resources :sessions, only: :create
  end

  namespace :manage do
    root to: "dashboards#show"
    resources :chapters,
              only: [:index, :new, :create,
                     :edit, :update, :destroy] do
      resources :sections, only: [:new, :create]
    end

    resources :questions,
              only: [:edit, :update, :destroy] do
      resources :answers, only: [:new, :create]
    end

    resources :answers, only: [:destroy]
    resources :articles,
              only: [:index, :new, :create, :edit, :update, :destroy]
    resources :products,
              only: [:index, :edit, :update]
    resources :questions,
              only: [:new, :create, :index]
    resources :sections,
              only: [:edit, :update, :destroy]
    resources :tags,
              only: [:index, :new, :create, :edit, :update, :destroy]
    resources :users,
              only: [:index, :edit, :update]
  end

  namespace :course do
    root to: "dashboards#show"
    resources :sections, only: :show do
      resources :quizzes, only: :create
    end
    resources :quizzes, only: [] do
      resources :sessions, only: :create,
                           controller: "quiz/sessions"
    end
  end

  namespace :attachment do
    resources :youtube_videos, only: :show
  end
end
