class Api::V1::UsersController < Api::BaseController
  # Follow a user.
  def follow
    user           = User.find params[:user_id]
    user_following = User.find params[:following_id]

    Following.create(user_id: user.id, following_id: user_following.id)

    render json: { message: 'Successfully followed a user.', user_id: user.id, following_id: user_following.id, status: :ok }
  end

  # Unfollow a user.
  def unfollow
    user           = User.find params[:user_id]
    user_following = User.find params[:following_id]

    following      = Following.find_by user_id: user.id, following_id: user_following.id

    if following
      following.destroy

      render json: { message: 'Successfully unfollowed a user.', user_id: user.id, following_id: user_following.id, status: :ok }
    else
      render json: { message: 'Error unfollowing. No such relationship found.', status: :not_found }
    end
  end

  # List friends' sleeping records the past week and have them sorted by sleep length.
  def friends_records
    user = User.find params[:user_id]

    user_followings              = User.where(id: user.followings.map(&:following_id))
    followings_last_week_records = user_followings.map { |user_following| user_following.last_week_records_by_length }

    render json: { message: 'Successfully retrieved friends records', user_id: user.id, records: followings_last_week_records.as_json, status: :ok }
  end
end
