class Api::V1::SleepsController < Api::BaseController
  # Set the sleep time
  def sleep
    user = User.find params[:user_id]

    Sleep.create(user_id: user.id, start_time: Time.current )

    render json: { message: 'Successfully set the sleep time', user_id: user.id, status: :ok }
  end

  # Set the wake up time
  def wake_up
    user = User.find params[:user_id]

    sleeping = Sleep.find_by(user_id: user.id, end_time: nil)

    if sleeping
      sleeping.update(end_time: Time.current, length: ((Time.current - sleeping.start_time) / 3600).round)

      render json: { message: 'Successfully set the wake up time', user_id: user.id, status: :ok }
    else
      render json: { message: 'Error setting wake up time. No corresponding sleep time.', user_id: user.id, status: :not_found }
    end
  end

  # Get all clocked ín times
  def clocked_ins
    user = User.find params[:user_id]

    render json: { message: 'Successfully retrieved clocked ins.', user_id: user.id, sleepings: user.sleeps.order(:created_at).as_json, status: :ok }
  end
end
