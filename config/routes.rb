Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get 'find' => 'search#show'
        get 'find_all' => 'search#index'
        get 'most_revenue' => 'revenue#index'
      end
      resources :merchants, only: [:index, :show] do
        get 'revenue', to: 'merchants/revenue_by_date#show'
      end
    end
  end
end
