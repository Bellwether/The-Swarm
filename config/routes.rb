TheSwarm::Application.routes.draw do
  resource :account, :only => [:show,:edit,:update], :controller => 'accounts'
  resources :users, :only => [:index,:new,:create]
  resource :user, :only => [:edit,:update], :controller => 'users'
  
  resources :campaigns, :only => [:index,:show,:new,:create,:destroy] do
    resources :messages, :only => [:new,:create,:show]
  end
  
  resources :contacts do
    resources :subscriptions, :only => [:new,:create,:destroy]
  end
  
  resource :login, :only => [:new,:create,:destroy]

  root :to => 'campaigns#index'
end
