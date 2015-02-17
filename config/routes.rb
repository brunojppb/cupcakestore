Rails.application.routes.draw do
  root  'static_pages#home'

  get   'registrar'          =>      'users#new'

  resources :users
end
