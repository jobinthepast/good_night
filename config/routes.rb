Rails.application.routes.draw do
  root to: 'pages#dashboard'

  namespace :api do
    namespace :v1 do
      post '/:user_id/sleep',       to: 'sleeps#sleep',       as: 'sleep'
      post '/:user_id/wake_up',     to: 'sleeps#wake_up',     as: 'wake_up'
      get  '/:user_id/clocked_ins', to: 'sleeps#clocked_ins', as: 'clocked_ins'

      post   '/:user_id/follow/:following_id',   to: 'users#follow',          as: 'follow'
      delete '/:user_id/unfollow/:following_id', to: 'users#unfollow',        as: 'unfollow'
      get    '/:user_id/friends_records',        to: 'users#friends_records', as: 'friends_records'
    end
  end
end
