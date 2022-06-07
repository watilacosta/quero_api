# frozen_string_literal: true

Rails.application.routes.draw do
  # resources :bills
  resources :enrollments, only: %i[index create]
  resources :students, only: %i[index create]
end
