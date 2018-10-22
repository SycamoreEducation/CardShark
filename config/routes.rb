CardShark::Engine.routes.draw do
  resources :cards, only: :create
  resources :stories, only: [:index, :create]
end
