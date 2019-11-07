class Api::V1::SleepsController < Api::BaseController
  # Get all clocked ín times
  def clocked_ins
    render json: { message: 'Successfully retrieved clocked ins.', user_id: @user.id, sleepings: @user.sleeps.order(:created_at).as_json, status: :ok }
  end

  # List friends' sleeping records the past week and have them sorted by sleep length.
  def friends_records
    user_followings              = User.where(id: @user.followings.map(&:following_id))
    followings_last_week_records = user_followings.map { |user_following| user_following.last_week_records_by_length }

    render json: { message: 'Successfully retrieved friends records', user_id: @user.id, sleepings: followings_last_week_records.as_json, status: :ok }
  end
end
