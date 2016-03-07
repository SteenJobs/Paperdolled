Rails.application.routes.draw do
  mount RedactorRails::Engine => '/redactor_rails'
  
  
  devise_scope :user do
    # using login path for registration
    #get '/login' => 'registrations#new', :as => :new_user_signup
    #post '/sign_up' => 'registrations#create', :as => :user_signup
    #post '/sign_in' => 'devise/sessions#create', :as => :user_login
    get "/" => "registrations#new"
    get 'users/sign_in', to: redirect('/')
    get 'users/sign_up', to: redirect('/')
    put '/update' => "registrations#update", as: "user_update"
    get 'users/edit' => "registrations#edit", as: "devise_user_edit"
    get 'users/:id' => "users#show", as: "user_show"
  end

  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks", :registrations => "registrations" }
  #get '/auth/:provider/callback' => 'authentication#create'
  #get '/auth/:provider/signout' => 'authentication#signout'


  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  resources :users do 
    resources :outfits
    resources :closets, only: [:create]
  end

  resources :scenarios
  resources :answers
  resources :items
  
  get '/about' => 'welcome#about', as: "about"
  root 'welcome#index'

end
