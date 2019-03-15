Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get 'find' => 'search#show'
        get 'find_all' => 'search#index'
        get 'random' => 'random#show'
        get 'most_revenue' => 'revenue#index'
        get 'most_items' => 'most_items#index'
      end
      resources :merchants, only: [:index, :show] do
        get 'revenue' => 'merchants/revenue_by_date#show'
        get 'items' => 'merchants/items_by_merchant#index'
        get 'invoices' => 'merchants/invoices_by_merchant#index'
      end
    end
  end
end
