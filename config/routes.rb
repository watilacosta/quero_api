# frozen_string_literal: true

Rails.application.routes.draw do
  resources :bills
  resources :enrollments
  resources :students, only: %i[index create]
end
