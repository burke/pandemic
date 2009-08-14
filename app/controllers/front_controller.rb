class FrontController < ApplicationController

  def index
    if current_user || true #HEY CHANGEME IM JUST HERE FOR DEBUG LISTEN TO ME HEY YOU CHANGE ME GET RID OF THIS LAST BIT.
      redirect_to :controller => "meetings"
    else
      redirect_to '/login'
    end
  end

end
