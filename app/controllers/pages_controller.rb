class PagesController < ApplicationController
  def dashboard
    @users = User.all
  end
end
