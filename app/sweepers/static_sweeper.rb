class StaticSweeper < ActionController::Caching::Sweeper

  def self.sweep
   blacklist = %W{ 404.html
                   422.html
                   500.html
                   blank.html}
   
   blacklist.map! { |file| RAILS_ROOT + "/public/"+file }               
   cached = Dir[ "#{RAILS_ROOT}/public/**.html"]
   
   cached -= blacklist
   
   cached.each do |file|
     FileUtils.rm_r(file)
     message = "[ deleted ] #{file}" 
     puts message
     RAILS_DEFAULT_LOGGER.info(message)
   end 
  end
end

