class AdminController < ApplicationController
  before_filter :authenticate, :only_admin
  private
  def only_admin
    deny_access unless current_user.is_an_admin?
  end
end