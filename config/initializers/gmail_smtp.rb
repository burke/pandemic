require "smtp_tls" #if RUBY_VERSION == '1.8.6'

ActionMailer::Base.smtp_settings = { 
                                      :address        => "smtp.gmail.com", 
                                      :port           => 587, 
                                      :domain         => "gmail.com",
                                      :user_name      => "test@53cr.com", 
                                      :password       => "tester", 
                                      :authentication => :plain 
                                    } 
