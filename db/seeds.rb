# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Create Admin Users
AdminUser.find_or_create_by!(email: "adekunle.adebayo@fupre.edu.ng") do |user|
  user.password = "password123"
  user.password_confirmation = "password123"
  user.name = "Adekunle Adebayo"
  user.role = "admin"
end

AdminUser.find_or_create_by!(email: "ngozi.okoro@fupre.edu.ng") do |user|
  user.password = "password123"
  user.password_confirmation = "password123"
  user.name = "Ngozi Okoro"
  user.role = "admin"
end

# Assign a default admin user for sample data
admin_user = AdminUser.first

# Sample Posts
5.times do |i|
  Post.find_or_create_by!(title: "Sample Post #{i + 1}") do |post|
    post.summary = "This is a summary for sample post #{i + 1}."
    post.content = "This is the full content for sample post #{i + 1}. It's a bit longer than the summary."
    post.status = i.even? ? :published : :draft
    post.published_at = Time.current if post.published?
    post.admin_user = admin_user
    post.post_type = Post.post_types.keys.sample
    post.severity = Post.severities.keys.sample
    post.source = Post.sources.keys.sample
  end
end

# Sample Events
5.times do |i|
  Event.find_or_create_by!(title: "Sample Event #{i + 1}") do |event|
    event.details = "Details for sample event #{i + 1}."
    event.start_date = Date.current + (i * 2).days
    event.event_time = Time.current
    event.admin_user = admin_user
    event.event_type = [ "event", "deadline" ].sample
  end
end
