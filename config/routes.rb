TheSwarm::Application.routes.draw do
  resource :account, :only => [:show,:edit,:update]
  resources :users, :only => [:index,:new,:create]

  resources :campaigns, :only => [:index,:show,:new,:create,:destroy] do
    resources :messages, :only => [:new,:create,:show]
  end
  
  resources :contacts do
    resources :subscriptions, :only => [:new,:create,:destroy]
  end

  root :to => 'account#index'
end
