Factory.define :confirmed_user, 
               :class => 'user' do |user|

  user.email                 { Factory.next :email }
  user.password              "password"
  user.password_confirmation "password"
  user.confirmed             true
end

Factory.define :user do |user|
  user.email { Factory.next :email }
  user.password "password"
  user.password_confirmation "password"
end
