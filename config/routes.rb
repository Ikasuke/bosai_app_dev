# frozen_string_literal: true

Rails.application.routes.draw do
  #activeadmin
  ActiveAdmin.routes(self)
  #devise
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

## no model
  root 'start#index'
  get 'home', to: 'home#index'

## user model
 get 'user/profile', to: 'users#profile'
 resources :users

 ##  remindmail model
 resources :remindmails


end
