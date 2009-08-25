class DashboardController < ApplicationController
  before_filter :require_user

  def index
    @user = current_user
    @meetings = Meeting.find(:all,:conditions => ["user_id = ? and created_at > ?", @user, Date.today])
  end
end
