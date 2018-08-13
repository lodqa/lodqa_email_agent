# frozen_string_literal: true

Rails.application.routes.draw do
  resources :queries, :constraints => { :id => /[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}/ } , only: [] do
     resource :progress, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
