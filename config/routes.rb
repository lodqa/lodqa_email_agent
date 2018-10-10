# frozen_string_literal: true

Rails.application.routes.draw do
  # http://www.nslabs.jp/email-address-regular-expression.rhtml
  VALID_EMAIL_REGEX = /[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*/
  resources :mail_address, constraints: { id: VALID_EMAIL_REGEX } , only: [] do
    resources :mail_subject, constraints: { id: :none }, only: [] do
      resource :events, only: :create
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
