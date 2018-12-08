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

  ## user model
  get "user/profile", to: "users#profile"
  resources :users

  ##  remindmail model
  resources :remindmails

  ##item model
  resources :items
  post "item/reading_table", to: "items#reading_table"  #グッズ検索でコントローラに検索params(:search)をコントローラへ送る

  ##category model
  resources :categories

  ##comment model
  resources :comments

  ##likeitem model
  resources :likeitems

  ##murmur model
  resources :murmurs
  post "murmur/region", to: "murmurs#region"

  ##favorite model
  resources :favorites
end
