namespace :admin do
  desc "Create admin user with default credentials"
  task create: :environment do
    admin_user = AdminUser.find_or_create_by!(email: "admin@fupre.edu.ng") do |user|
      user.password = "fupre2024"
      user.password_confirmation = "fupre2024"
      user.name = "Admin User"
      user.role = "admin"
    end
    puts "Admin user created successfully with email: #{admin_user.email}"
  end
end
