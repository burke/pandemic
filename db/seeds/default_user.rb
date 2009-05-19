User.delete_observers
a = Administrator.create!(:login                 => 'Admin', 
                          :email                 => 'test@53cr.com',
                          :password              => 'changeme',
                          :password_confirmation => 'changeme')  

a.update_attribute :state,'confirmed'

