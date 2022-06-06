Rails.application.routes.draw do
  resources :bills
  resources :enrollments
  resources :students, only: %i[index create]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
