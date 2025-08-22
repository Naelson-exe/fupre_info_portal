FactoryBot.define do
  factory :event do
    association :admin_user
    event_type { %w[deadline exam holiday fee_payment].sample }
    start_date { Faker::Time.between(from: 2.years.ago, to: Date.today) }

    trait :deadline do
      title { "Assignment Deadline" }
      details { "Submit your work for #{Faker::Educator.course_name}." }
    end

    trait :exam do
      title { "#{Faker::Educator.course_name} Exam" }
      details { "The final exam will be held in #{Faker::Address.community}." }
    end

    trait :holiday do
      title { "Public Holiday" }
      details { "The university will be closed for #{Faker::Lorem.word}." }
    end

    trait :fee_payment do
      title { "School Fees Payment Deadline" }
      details { "All students are to pay their school fees on or before the deadline." }
    end
  end
end
