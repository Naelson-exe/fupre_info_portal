namespace :db do
  desc "Check database state"
  task check: :environment do
    puts "Checking admin_users table..."

    # Check all admin users
    puts "\nAll admin users:"
    AdminUser.all.each do |user|
      puts "- Email: #{user.email}, Name: #{user.name}, Role: #{user.role}, Created: #{user.created_at}"
    end

    # Check for duplicate emails
    puts "\nChecking for duplicate emails..."
    duplicate_emails = AdminUser.group(:email).having("COUNT(*) > 1").count
    if duplicate_emails.any?
      puts "Found duplicate emails:"
      duplicate_emails.each do |email, count|
        puts "- #{email}: #{count} occurrences"
      end
    else
      puts "No duplicate emails found"
    end

    # Check for invalid records
    puts "\nChecking for invalid records..."
    invalid_records = AdminUser.where("email IS NULL OR email = '' OR password_digest IS NULL")
    if invalid_records.any?
      puts "Found invalid records:"
      invalid_records.each do |record|
        puts "- ID: #{record.id}, Email: #{record.email}, Password Digest: #{record.password_digest}"
      end
    else
      puts "No invalid records found"
    end

    # Check database schema
    puts "\nDatabase schema:"
    puts AdminUser.column_names.join(", ")
  end
end
