Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get 'most_revenue' => 'search#index'
        get 'find' => 'search#show'
      end
      resources :merchants, only: [:index, :show]
    end
  end
end
# find an id with the date in spec harness, and expect it to come out to as the spec harness expects
# when you use a finder, search for the date format from the spec harness

# finders use strong params
# case insensitive searches: column type in postgres called ci text (instead of text)
