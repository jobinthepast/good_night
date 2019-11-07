class Api::BaseController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action      :get_users

  include ExceptionHandler

  def get_users
    @user            = User.find params[:user_id]
    @user_following  = User.find params[:following_id] if params[:following_id]
  end
end
