Goalbet::Application.routes.draw do
  root to: 'goal#landing'

  post 'reach' => 'goal#reach'
end
