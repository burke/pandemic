class DashboardController < ApplicationController
  before_filter :require_user

  def index
    @user = current_user
    @locations = Location.find(:all)
    @meetings = Meeting.find(:all, :order => "created_at DESC", :conditions => ["user_id = ? and created_at > ?", @user, Date.today])
  end
end
