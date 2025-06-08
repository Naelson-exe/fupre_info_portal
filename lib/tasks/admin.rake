namespace :admin do
  desc "Create default admin user"
  task create: :environment do
    AdminUser.create!(
      email: "admin@example.com",
      password: "password123",
      password_confirmation: "password123",
      name: "Admin User",
      role: "admin"
    ) rescue puts "Admin user already exists"
  end
end
