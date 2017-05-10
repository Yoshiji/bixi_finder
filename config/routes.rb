Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'bixi_stations#index'

  resources :bixi_stations, only: [:index] do
    collection do
      post :fetch
      post :refresh
    end
  end
end
