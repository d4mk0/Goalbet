Goalbet::Application.routes.draw do
  root to: 'goal#landing'

  match '/reach', to: 'goal#reach', via: :all
  get 'strategy', to: 'goal#strategy'

  namespace :api do
    match 'bets_count', to: 'goal#bets_count', defaults: {format: :json}, via: :get
    match 'next_bet_size', to: 'goal#next_bet_size', defaults: {format: :json}, via: :get
  end
end
