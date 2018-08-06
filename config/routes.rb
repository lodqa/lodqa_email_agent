# frozen_string_literal: true

Rails.application.routes.draw do
  resources :queries, only: [] do
     resource :progress, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
