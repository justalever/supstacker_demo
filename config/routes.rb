Rails.application.routes.draw do
  resources :stacks, param: :share_link do
    resources :products do
      get 'remove_thumbnail', on: :member
    end
  end
  resources :brands

  if defined?(Sidekiq)
    require "sidekiq/web"
    mount Sidekiq::Web => "/sidekiq"
  end

  if Rails.env.development? || Rails.env.test?
    mount Railsui::Engine, at: "/railsui"
  end

  # Inherits from Railsui::PageController#index
  # To overide, add your own page#index view or change to a new root
  # Visit the start page for Rails UI any time at /railsui/start
  # root action: :index, controller: "railsui/page"

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "stacks#index"
end
