FactoryGirl.define do
  factory :user do
    name           "Alice Wonderland"
    email          "alice@wonderland.com"
    citizen_number "100100100"
    password "secret"
    password_confirmation "secret"
  end
end