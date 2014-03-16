FactoryGirl.define do
  factory :user do
    sequence(:name)           { |n| "Person #{n}" }
    sequence(:email)          { |n| "person_#{n}@example.com"}
    sequence(:citizen_number) { |n| "1001001#{n}" }
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end
end
