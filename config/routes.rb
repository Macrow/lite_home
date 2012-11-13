LiteHome::Engine.routes.draw do  
  root :to => 'sessions#index'

  # sessions
  get 'login' => 'sessions#new', as: :login
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy', as: :logout
  
  # registers
  get 'register' => 'registers#new', as: :register
  post 'register' => 'registers#create'
  
  # password resets
  get 'forgot_password' => 'password_resets#new', as: :forgot_password
  post 'forgot_password' => 'password_resets#create'
  get 'reset_password/:token' => 'password_resets#edit', as: :reset_password
  put 'reset_password/:token' => 'password_resets#update'
  
  # profile
  get 'profile' => 'profile#index', as: :profile
  get 'profile/edit' => 'profile#edit', as: :profile_edit
  put 'profile' => 'profile#update'
  get 'profile/change_avatar' => 'profile#edit_avatar', as: :profile_avatar
  put 'profile/change_avatar' => 'profile#update_avatar'
  put 'profile/crop_avatar' => 'profile#crop_avatar', as: :profile_crop_avatar
  get 'profile/change_password' => 'profile#edit_password', as: :profile_change_password
  put 'profile/change_password' => 'profile#update_password'
  get 'profile/destroy' => 'profile#confirm_destroy', as: :profile_destroy
  delete 'profile/destroy' => 'profile#destroy'
  
  # users
  get 'users/:name' => 'users#show', as: :user_show
  
  # administration
  namespace :admin do
    resources :users, except: :show
    root :to => 'users#index'
  end
end
