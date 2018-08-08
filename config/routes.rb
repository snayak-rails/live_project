# frozen_string_literal: true

Rails.application.routes.draw do
  resources :skills
  resources :projects
  devise_for :employees

  resources :employees do
    member do
      post :create_employee_projects
      post :create_employee_skills
      get :edit_employee_project
      put :update_employee_project
      get :edit_employee_skill
      put :update_employee_skill
    end
  end

  root 'employees#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
