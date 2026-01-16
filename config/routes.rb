Rails.application.routes.draw do
  get "meal_plan_entries/create"
  get "meal_plan_entries/destroy"
  get "meal_plans/show"
  resources :grocery_lists, only: %i[index new create show destroy] do
    resources :grocery_list_items, only: %i[create update]
  end
  resource :meal_plan, only: %i[show]
  resources :meal_plan_entries, only: %i[create destroy]
  resources :recipes
  resource :session
  resources :passwords, param: :token
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  root "recipes#index"
end
