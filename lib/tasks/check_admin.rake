namespace :admin do
  desc "Check admin user credentials"
  task check: :environment do
    admin_user = AdminUser.find_by(email: "admin@fupre.edu.ng")
    if admin_user
      puts "Admin user found with email: #{admin_user.email}"
      puts "Password digest: #{admin_user.password_digest}"
    else
      puts "No admin user found with email admin@fupre.edu.ng"
    end
  end
end
