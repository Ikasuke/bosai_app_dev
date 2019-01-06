# frozen_string_literal: true
require "sidekiq/web"

Rails.application.routes.draw do
  #activeadmin
  ActiveAdmin.routes(self)
  #devise
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #sidekiq
  authenticate :user, -> (u) { u.admin? } do
    mount Sidekiq::Web, at: "/sidekiq"
  end

  ## no model
  root "start#index"
  get "home", to: "home#index"
  get "adminhome", to: "home#adminhome"
  get "user/area", to: "users#area"
  get "info", to: "info#index"
  get "start_info", to: "start#start_info"
  ## user model
  get "user/profile", to: "users#profile"
  resources :users

  ##  remindmail model
  resources :remindmails

  ##item model
  resources :items

  ##category model
  resources :categories

  ##subcategory model
  resources :subcategories

  ##comment model
  resources :comments

  ##likeitem model
  resources :likeitems

  ##murmur model
  resources :murmurs

  ##favorite model
  resources :favorites
end
