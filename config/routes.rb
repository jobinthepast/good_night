Rails.application.routes.draw do
  root to: 'pages#dashboard'

  namespace :api do
    namespace :v1 do
      get  '/:user_id/clocked_ins',     to: 'sleeps#clocked_ins',     as: 'clocked_ins'
      get  '/:user_id/friends_records', to: 'sleeps#friends_records', as: 'friends_records'

      post   '/:user_id/follow/:following_id',   to: 'users#follow',   as: 'follow'
      delete '/:user_id/unfollow/:following_id', to: 'users#unfollow', as: 'unfollow'
      post   '/:user_id/sleep',                  to: 'users#sleep',    as: 'sleep'
      post   '/:user_id/wake_up',                to: 'users#wake_up',  as: 'wake_up'
    end
  end
end
