Factory.define :user do |user|
  user.sequence(:email) { |n| "person#{n}@example.com" }
  user.sequence(:login) { |n| "login#{n}"}
  user.password "password"
  user.password_confirmation "password"
end

