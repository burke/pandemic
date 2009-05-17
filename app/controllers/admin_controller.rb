class AdminController < ApplicationController
  before_filter :require_user,:only_admin
  
  private
  def only_admin
    insufficient_privileges unless current_user.is_a?(Administrator)
  end
end
