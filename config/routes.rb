# frozen_string_literal: true

DiscourseSubscriptions::Engine.routes.draw do
  # TODO: namespace this
  scope 'admin' do
    get '/' => 'admin#index'
  end

  namespace :admin do
    resources :plans
    resources :subscriptions, only: [:index, :destroy]
    resources :products
  end

  namespace :user do
    resources :payments, only: [:index]
    resources :subscriptions, only: [:index, :destroy]
  end

  resources :customers, only: [:create]
  resources :hooks, only: [:create]
  resources :invoices, only: [:index]
  resources :payments, only: [:create]
  resources :plans, only: [:index]
  resources :products, only: [:index, :show]
  resources :subscriptions, only: [:create]

  get '/' => 'subscriptions#index'
  get '/:id' => 'subscriptions#index'
end
