Factory.sequence :email do |n|
  "user#{n}@example.com"
end

Factory.define :user do |user|
  user.email { Factory.next :email }
  user.password "password"
  user.password_confirmation "password"
end

Factory.define :role do |role|
end

Factory.define :admin, :class => User do |user|
  user.email { Factory.next :email }
  user.password "password" 
  user.password_confirmation "password"
  user.roles { |a| [a.association(:role,:name => :admin)] }
end

