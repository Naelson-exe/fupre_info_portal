FactoryBot.define do
  factory :post do
    association :admin_user
    status { %i[draft published archived].sample }
    post_type { %i[announcement memo].sample }
    severity { %i[low medium high].sample }
    source { %i[vc_office registrar bursary dean_of_students].sample }
    published_at { Faker::Time.between(from: 2.years.ago, to: Date.today) if status == :published }

    trait :announcement do
      title { "Important Announcement" }
      content { "Please be advised that #{Faker::Company.name} will be closed on #{Faker::Date.forward(days: 23)}." }
    end

    trait :memo do
      title { "Office Memo" }
      content { "This is a memo regarding #{Faker::Commerce.department}." }
    end
  end
end
