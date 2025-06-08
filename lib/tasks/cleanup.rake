namespace :admin do
  desc "Clean up admin users and create single admin user"
  task cleanup: :environment do
    puts "Cleaning up admin users..."
    
    # Delete all existing admin users
    AdminUser.delete_all
    puts "All existing admin users deleted"

    # Create new admin user
    admin_user = AdminUser.create!(
      email: "admin@fupre.edu.ng",
      password: "fupre2024",
      password_confirmation: "fupre2024",
      name: "Admin User",
      role: "admin"
    )
    puts "New admin user created with email: #{admin_user.email}"

    # Clear session store
    if Rails.application.config.session_store == :active_record_store
      ActiveRecord::SessionStore::Session.delete_all
      puts "Session store cleared"
    end

    puts "Database cleanup complete"
  end
end
