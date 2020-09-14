Rails.application.routes.draw do
  get 'users' => 'home#index'
  get 'users/:id' => 'home#show'
  post 'users' => 'home#create'
  put 'users/:id' => 'home#update'
  delete 'users/:id' => 'home#delete'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
