Buggerall::Application.routes.draw do
  match '/bug/:resource_name' => 'buggerall#show'
  resources :resources, only: [:index]
  resources :request_signatures, only: [:index]
  resources :user_agents, only: [:index]
  resources :visitors, only: [:index]
  match "/" => redirect("https://github.com/brundage/buggerall")
  match "*path" => redirect("https://github.com/brundage/buggerall")
end
