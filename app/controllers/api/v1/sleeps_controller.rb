class Api::V1::SleepsController < Api::BaseController
  # Set the sleep time
  def sleep
    user = User.where(id: params[:user_id]).first

    if user
      Sleep.create(user_id: user.id, start_time: Time.current )

      render json: { message: 'Successfully set the sleep time', user_id: user.id, status: :ok }
    end
  end

  # Set the ưake up time
  def wake_up
    user = User.where(id: params[:user_id]).first

    if user
      sleeping = Sleep.where(user_id: user.id, end_time: nil).first

      if sleeping
        sleeping.update(end_time: Time.current, length: ((Time.current - sleeping.start_time) / 3600).round)

        render json: { message: 'Successfully set the sleep time', user_id: user.id, status: :ok }
      end
    end
  end

  # Get all clocked ín times
  def clocked_ins
    user = User.where(id: params[:user_id]).first

    if user
      render json: { message: 'Successfully get clocked in.', user_id: user.id, status: :ok, sleepings: user.sleeps.order(:length).as_json }
    end
  end
end
