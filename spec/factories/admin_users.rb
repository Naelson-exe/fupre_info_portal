FactoryBot.define do
  factory :admin_user do
    sequence(:email) { |n| "admin#{n}@example.com" }
    name { "Admin User" }
    password { "password123" }
    role { "admin" }
    last_login_at { nil }

    trait :locked do
      failed_attempts { 5 }
      locked_at { Time.current }
    end
  end
end
