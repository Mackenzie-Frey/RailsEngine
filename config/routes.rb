Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get 'find' => 'search#show'
        get 'find_all' => 'search#index'
        get 'random' => 'random#show'
        get 'most_revenue' => 'most_revenue#index'
        get 'most_items' => 'most_items#index'
        get 'revenue' => 'revenue_by_date#index'
      end
      resources :merchants, only: [:index, :show] do
        get 'revenue' => 'merchants/revenue_by_date#show'
        get 'items' => 'merchants/items_by_merchant#index'
        get 'invoices' => 'merchants/invoices_by_merchant#index'
        get 'favorite_customer' => 'merchants/favorite_customer#show'
      end

      namespace :customers do
        get 'find' => 'search#show'
        get 'find_all' => 'search#index'
        get 'random' => 'random#show'
      end
      resources :customers, only: [:index, :show] do
        get 'invoices' => 'customers/invoices_of_customer#index'
        get 'transactions' => 'customers/transactions_of_customer#index'
        get 'favorite_merchant' => 'customers/favorite_merchant#show'
      end

      namespace :items do
        get 'find' => 'search#show'
        get 'find_all' => 'search#index'
        get 'random' => 'random#show'
        get 'most_revenue' => 'most_revenue#index'
      end
      resources :items, only: [:index, :show] do
        get 'invoice_items' => 'items/associated_invoice_items#index'
        get 'merchant' => 'items/associated_merchant#show'
      end

      namespace :invoices do
        get 'find' => 'search#show'
        get 'find_all' => 'search#index'
        get 'random' => 'random#show'
      end
      resources :invoices, only: [:index, :show] do
        get 'transactions' => 'invoices/associated_transactions#index'
        get 'invoice_items' => 'invoices/associated_invoice_items#index'
        get 'items' => 'invoices/associated_items#index'
        get 'customer' => 'invoices/associated_customer#show'
        get 'merchant' => 'invoices/associated_merchant#show'
      end

      namespace :transactions do
        get 'find' => 'search#show'
        get 'find_all' => 'search#index'
        get 'random' => 'random#show'
      end
      resources :transactions, only: [:index, :show] do
        get 'invoice' => 'transactions/associated_invoice#show'
      end

      namespace :invoice_items do
        get 'find' => 'search#show'
        get 'find_all' => 'search#index'
        get 'random' => 'random#show'
      end
      resources :invoice_items, only: [:index, :show] do
        get 'invoice' => 'invoice_items/associated_invoice#show'
        get 'item' => 'invoice_items/associated_item#show'
      end
    end
  end
end
