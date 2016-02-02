FactoryGirl.define do
  factory :user do
    email 'admin@example.com'
    login 'admin'
    password '123123'
    password_confirmation '123123'
  end

end
