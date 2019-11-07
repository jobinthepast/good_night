class Api::V1::UsersController < Api::BaseController
  # Follow a user.
  def follow
    Following.create(user_id: @user.id, following_id: @user_following.id)

    render json: { message: 'Successfully followed a user.', user_id: @user.id, following_id: @user_following.id, status: :ok }
  end

  # Unfollow a user.
  def unfollow
    following = Following.find_by user_id: @user.id, following_id: @user_following.id

    if following
      following.destroy

      render json: { message: 'Successfully unfollowed a user.', user_id: @user.id, following_id: @user_following.id, status: :ok }
    else
      render json: { message: 'Error unfollowing. No such relationship found.', status: :not_found }
    end
  end

  # Set the sleep time
  def sleep
    Sleep.create(user_id: @user.id, start_time: Time.current )

    render json: { message: 'Successfully set the sleep time', user_id: @user.id, status: :ok }
  end

  # Set the wake up time
  def wake_up
    sleeping = Sleep.find_by(user_id: @user.id, end_time: nil)

    if sleeping
      sleeping.update(end_time: Time.current, length: ((Time.current - sleeping.start_time) / 3600).round)

      render json: { message: 'Successfully set the wake up time', user_id: @user.id, status: :ok }
    else
      render json: { message: 'Error setting wake up time. No corresponding sleep time.', user_id: @user.id, status: :not_found }
    end
  end
end
