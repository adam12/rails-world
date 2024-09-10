Rails.application.routes.draw do
  constraints AuthenticatedConstraint.new do
    root "sessions#index"
  end

  constraints UnauthenticatedConstraint.new do
    root "user_sessions#new", as: :unauthenticated_root
  end

  get "up" => "rails/health#show", :as => :rails_health_check
  get "/service-worker.js" => "service_worker#service_worker"
  get "/offline.html" => "service_worker#offline"
  get "/manifest.json" => "service_worker#manifest"

  mount MissionControl::Jobs::Engine, at: "/jobs"
  mount Avo::Engine, at: Avo.configuration.root_path

  resource :registration, only: [:new, :create]
  resource :user_session, only: [:new, :create, :destroy]
  resource :password, only: [:edit, :update]
  resource :password_reset, only: [:new, :create, :edit, :update] do
    get :post_submit
  end
  resource :user_session_settings, only: [:edit, :update]
  resource :read_notifications, only: [:create]
  resource :notification_settings, only: [:show, :update]
  resource :coming_soon, only: [:show]
  resource :about, only: [:show]
  resource :schedule, only: [:show]

  resources :sessions, only: [:index, :show] do
    resource :attendee, only: [:create, :destroy]
  end
  resources :speakers, only: [:show]
  resources :profiles, only: [:show, :edit, :update], param: :uuid
  resources :notifications, only: [:index]
  resources :web_push_subscriptions, only: [:create]
end
