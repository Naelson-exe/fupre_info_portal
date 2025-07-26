namespace :db do
  desc "Create sample data for testing"
  task sample_data: :environment do
    # Create admin user if none exists
    unless AdminUser.exists?
      admin = AdminUser.create!(
        email: "admin@fupre.edu.ng",
        password: "password123",
        name: "Admin User",
        role: "admin"
      )
      puts "Created admin user: #{admin.email}"
    end

    admin = AdminUser.first

    # Create sample posts
    3.times do |i|
      Post.create!(
        title: "Sample Post #{i + 1}",
        summary: "This is a summary for sample post #{i + 1}",
        content: "This is the content for sample post #{i + 1}. It contains more detailed information.",
        status: "published",
        admin_user: admin,
        published_at: Time.current
      )
    end

    # Create sample events
    3.times do |i|
      Event.create!(
        title: "Sample Event #{i + 1}",
        details: "This is the details for sample event #{i + 1}",
        event_date: Date.current + (i + 1).days,
        event_time: Time.current + (i + 2).hours,
        admin_user: admin
      )
    end

    puts "Sample data created successfully!"
  end
end