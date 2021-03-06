class MeetingsController < ApplicationController

  before_filter :require_user

  # GET /meetings/new
  # GET /meetings/new.xml
  def new
    @meeting = Meeting.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @meeting }
    end
  end

  # POST /meetings
  # POST /meetings.xml
  def create
    @meeting = Meeting.new(params[:meeting])

    @meeting.user = @current_user
    @meeting.location = Location.find(params[:location])
    
    if u = params[:name]
      u.sub(/,$/,'').split(',').each{|a| @meeting.people << Person.find(a)}
    end
    if t = params[:time]
      if t =~ /m/
        @meeting.duration = 60*t.to_i
      elsif t =~ /h/
        @meeting.duration = 3600*t.to_i
      end
    end
    
    respond_to do |format|
      if @meeting.save
        format.html do
          # redirect_to(@meeting)
          render :partial => @meeting
        end
        format.xml  { render :xml => @meeting, :status => :created, :location => @meeting }
        format.json   { render :text => {"name" => @meeting.people.map(&:name).join(", "), "time_str" => @meeting.time_str}.to_json }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @meeting.errors, :status => :unprocessable_entity }
        format.json   { render :text => {"error" => "could not save"}.to_json }
      end
    end
  end
  
  # DELETE /meetings/1
  # DELETE /meetings/1.xml
  def destroy
    @meeting = Meeting.find(params[:id])
    @meeting.destroy

    respond_to do |format|
      format.html { redirect_to(meetings_url) }
      format.xml  { head :ok }
    end
  end
end
