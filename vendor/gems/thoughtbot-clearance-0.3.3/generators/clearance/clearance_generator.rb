class ClearanceGenerator < Rails::Generator::Base
  
  def initialize(*runtime_args)
     super(*runtime_args)
    puts args.inspect
    @suffix = (args[0] || 'erb')
  end
  
  def manifest
    record do |m|
      m.directory File.join("app", "controllers")
      ["app/controllers/confirmations_controller.rb",
       "app/controllers/passwords_controller.rb", 
       "app/controllers/sessions_controller.rb", 
       "app/controllers/users_controller.rb"].each do |file|
        m.file file, file
      end
      
      m.directory File.join("app", "models")
      ["app/models/user.rb",
       "app/models/user_mailer.rb"].each do |file|
        m.file file, file
      end
      
      m.directory File.join("app", "views")
      m.directory File.join("app", "views", "confirmations")
      ["app/views/confirmations/new.html."+@suffix].each do |file|
        m.file file, file
      end
      
      m.directory File.join("app", "views", "passwords")
      ["app/views/passwords/new.html."+@suffix,
       "app/views/passwords/edit.html."+@suffix].each do |file|
        m.file file, file
      end
      
      m.directory File.join("app", "views", "sessions")
      ["app/views/sessions/new.html."+@suffix].each do |file|
        m.file file, file
      end
      
      m.directory File.join("app", "views", "user_mailer")
      ["app/views/user_mailer/change_password.html."+@suffix,
       "app/views/user_mailer/confirmation.html."+@suffix].each do |file|
        m.file file, file
      end
      
      m.directory File.join("app", "views", "users")
      ["app/views/users/_form.html."+@suffix,
       "app/views/users/edit.html."+@suffix,
       "app/views/users/new.html."+@suffix].each do |file|
        m.file file, file
      end
      
      m.directory File.join("test", "functional")
      ["test/functional/confirmations_controller_test.rb",
       "test/functional/passwords_controller_test.rb",
       "test/functional/sessions_controller_test.rb",
       "test/functional/users_controller_test.rb"].each do |file|
        m.file file, file
      end
      
      m.directory File.join("test", "unit")
      ["test/unit/user_mailer_test.rb",
       "test/unit/user_test.rb"].each do |file|
        m.file file, file
      end
      
      ["test/factories.rb"].each do |file|
        m.file file, file
      end
    end
  end
  
end
