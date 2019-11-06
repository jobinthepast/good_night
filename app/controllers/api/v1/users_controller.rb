class Api::V1::UsersController < Api::BaseController
  # Follow a user.
  def follow
    user           = User.where(id: params[:user_id]).first
    user_following = User.where(id: params[:following_id]).first

    if user && user_following
      Following.create(user_id: user.id, following_id: user_following.id)

      render json: { message: 'Successfully following.', user_id: user.id, following_id: user_following_id, status: :ok }
    end
  end

  # Unfollow a user.
  def unfollow
    user           = User.where(id: params[:user_id]).first
    user_following = User.where(id: params[:following_id]).first

    if user && user_following
      following = Following.where(user_id: user.id, following_id: user_following.id).first

      if following
        following.destroy
        render json: { message: 'Successfully unfollowing.', user_id: user.id, following_id: user_following.id, status: :ok }
      end
    end
  end

  # List friends' sleeping records the past week.
  def friends_records
    user = User.where(id: params[:user_id]).first

    if user
      user_followings = User.where(id: user.followings.map(&:following_id))
      followings_last_week_records = user_followings.map { |user_following| user_following.last_week_records }

      render json: { message: 'Successfully get friends records', user_id: user.id, records: followings_last_week_records.as_json }
    end
  end
end
