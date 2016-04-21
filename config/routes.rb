Rails.application.routes.draw do

  resources :games, except: [:edit, :destroy, :index, :update] do
    patch :fire, on: :member, defaults: { format: :json }
  end
  root 'games#new'
end
