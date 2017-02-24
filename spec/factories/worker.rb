FactoryGirl.define do
  factory :worker do
    email "worker@test.com"
    password "123123"
    password_confirmation "123123"
  end
end
