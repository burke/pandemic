class StatusesController < ApplicationController

  before_filter :require_user

  # GET /statuses/new
  # GET /statuses/new.xml
  def new
    @status = Status.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @status }
    end
  end

  # POST /statuses
  # POST /statuses.xml
  def create
    @status = Status.new
    @status.feeling_sick = params[:feeling_sick]
    @status.symptoms = params[:symptoms]
    @status.user = @current_user
    
    respond_to do |format|
      if @status.save
        format.html do
          redirect_to(@status)
          flash[:notice] = 'Status was successfully created.'
        end
        format.xml  { render :xml => @status, :status => :created, :location => @status }
        format.json { render :text => "success".to_json }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @status.errors, :status => :unprocessable_entity }
        format.json { render :text => "error".to_json }
      end
    end
  end

end
