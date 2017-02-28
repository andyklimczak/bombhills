# frozen_string_literal: true
Rails.application.routes.draw do
  resource :messages, only: [:create]

  resources :spots do
    resources :meetups
  end
  get 'meetups' => 'meetups#index_all', as: :meetups

  resource :meetup_attendees, only: [:create, :destroy]

  devise_for :users, controllers: { registrations: 'registrations' }
  get 'users/:id' => 'users#show', via: :get, as: 'show_user'

  resources :posts

  get 'welcome/index'
  root 'welcome#index'

  %w(404 422 500).each do |code|
    get code, to: 'errors#show', code: code
  end

  get 'mailbox/inbox' => 'mailbox#inbox', as: :mailbox_inbox
  get 'mailbox/sent' => 'mailbox#sent', as: :mailbox_sent
  get 'mailbox/trash' => 'mailbox#trash', as: :mailbox_trash

  resources :conversations do
    member do
      post :reply
      post :trash
      post :untrash
    end
  end

  resources :comments, only: [:create, :destroy]

  get 'robots.:format' => 'robots#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
