Rails.application.routes.draw do

  resources :games, only: [:create, :show], defaults: { format: :json } do
    patch :fire, on: :member
  end

end
