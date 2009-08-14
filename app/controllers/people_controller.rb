class PeopleController < ApplicationController
  def suggest
    @suggestions ||= {}
    @suggestions[params[:q]] ||=
      Person.
      find(:all,
           :conditions => ["name LIKE ?", "%#{params[:q]}%"],
           :limit => 5).
      map!{|p| "#{p[:name]}|#{p[:id]}" }.
      join("\n")

    respond_to do |format|
      format.json { render :text => @suggestions[params[:q]] }
    end
  end
end
