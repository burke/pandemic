class FrontController < ApplicationController

  def index
    if current_user
      redirect_to :controller => "dashboard"
    else
      redirect_to '/login'
    end
  end

end
