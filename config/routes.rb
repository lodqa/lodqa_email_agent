# frozen_string_literal: true

Rails.application.routes.draw do
  # http://www.nslabs.jp/email-address-regular-expression.rhtml
  VALID_EMAIL_REGEX = /[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*/
  resources :mail, constraints: { id: VALID_EMAIL_REGEX } , only: [] do
     resource :start, only: :create
     resource :finish, only: :create
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
