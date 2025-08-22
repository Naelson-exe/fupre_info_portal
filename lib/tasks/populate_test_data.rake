require "factory_bot_rails"

namespace :db do
  desc "Populate the database with realistic mock data for the development environment"
  task populate_test_data: :environment do
    Faker::Config.locale = "en-US"

    puts "Populating database with mock data..."

    # Create admin users
    admins = [
      AdminUser.first_or_create!(email: "john.doe@fupre.edu", name: "John Doe", password: "password", role: "admin"),
      AdminUser.first_or_create!(email: "jane.smith@fupre.edu", name: "Jane Smith", password: "password", role: "editor")
    ]

    # Create a variety of posts
    100.times do
      post_type = %i[announcement memo].sample
      FactoryBot.create(:post, post_type, admin_user: admins.sample)
    end

    # Create a variety of events
    50.times do
      event_type = %i[deadline exam holiday fee_payment].sample
      FactoryBot.create(:event, event_type, admin_user: admins.sample)
    end

    puts "Mock data population complete."
  end
end
