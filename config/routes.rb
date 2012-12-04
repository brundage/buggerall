Buggerall::Application.routes.draw do
  match '/bug/:resource_name' => 'bugger#show'
  resources :resources, only: [:index]
  resources :request_signatures, only: [:index]
  resources :user_agents, only: [:index]
end
