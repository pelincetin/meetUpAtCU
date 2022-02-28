Rails.application.routes.draw do
  resources :testings
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'profiles#index'

  resources :profiles, except: [:edit, :show]

  resources :messages, except: [:create, :random_create]

  get '/profiles/:id', to: 'profiles#show'
  
  post '/messages/random', to: 'messages#random_create', as: 'send_random_message'
  post '/messages/:id', to: 'messages#create', as: 'send_message'
 

  # Routes for Google authentication
  get 'auth/:provider/callback', to: 'sessions#googleAuth'
  get 'auth/failure', to: redirect('/')

  get 'show_my_profile', to: 'profiles#show_my_profile', as: 'show_my_profile'
  get "show_my_profile/edit", to: 'profiles#edit_me', as: 'edit_me'

  put 'show_my_profile', to: 'profiles#update_me'
  
  get 'auth/test', to: 'sessions#testAuth'
  
  delete 'signout', to: 'sessions#destroy', as: 'signout'

end
