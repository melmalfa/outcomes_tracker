Rails.application.routes.draw do

  resources :users

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root to: redirect('/login')

  get  '/login' => 'login#login'
  # called select because it selects if you are an admin or a student
  post '/login' => 'login#select'

  delete '/logout' => 'login#destroy'

  # admin pov!
  namespace :admin do
    get '/search' => 'searches#search'
    # see students list and individual
    resources :students, only: [:index, :show]
    # see cohorts list and individual
    resources :cohorts, only: [:index, :show] do
      # see students BY cohort as a list
      # resources :students, only: [:index]

      member do
        get :chart
      end
    end
    resources :courses, only: [:index, :show] do
      # see cohorts BY course as a list
      # resources :cohorts, only: [:index]
      member do
        get :chart
      end
    end
    resources :locations, only: [:index, :show] do
      # see cohorts BY location as a list
      # resources :cohorts, only: [:index]
    end
  end

  # student pov!
  resources :students do
    # the survey form

    member do
      get :survey
      post :survey
      post :update
    end

    collection do
      get :edit
    end


  end
end
