Goalbet::Application.routes.draw do
  root to: 'goal#landing'

  match '/reach', to: 'goal#reach', via: :all
  get 'strategy', to: 'goal#strategy'
end
