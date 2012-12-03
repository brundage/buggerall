Buggerall::Application.routes.draw do
  match '/bugger/bug/:resource_name' => 'bugger#show'
end
