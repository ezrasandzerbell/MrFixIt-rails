FactoryGirl.define do
  factory :user do
    email "user@test.com"
    password "123123"
    password_confirmation "123123"
  end
end
