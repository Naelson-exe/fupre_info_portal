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

# Sender details mapping
sender_details = {
  vc_office: { name: "Prof. Engr. Akpofure Rim-Rukeh", title: "Vice Chancellor" },
  registrar: { name: "Mrs. O.D. Ivwighreghweta", title: "Registrar" },
  bursary: { name: "Mr. Garba Yau", title: "Bursar" },
  dean_of_students: { name: "Dr. Alex O. Ogedegbe", title: "Dean of Student Affairs" }
}

# Clean up existing data to avoid duplicates
Post.destroy_all
Event.destroy_all

# --- ACADEMIC CALENDAR SIMULATION ---

# Define key dates for the academic year
today = Date.current
first_semester_start = 6.months.ago.to_date
first_semester_end = 2.months.ago.to_date
second_semester_start = 1.month.from_now.to_date
second_semester_end = 5.months.from_now.to_date

# --- FIRST SEMESTER ---

# Welcome and Orientation (First 2 weeks)
2.times do |i|
  Post.create!(
    title: "Welcome to the New Academic Session!",
    summary: "A warm welcome to all new and returning students for the first semester. This post contains important information to get you started.",
    content: "The management of the Federal University of Petroleum Resources, Effurun, is delighted to welcome you to the 2024/2025 academic session. We are committed to providing a conducive learning environment for all students. Please take note of the upcoming orientation program and other important events.",
    status: :published,
    published_at: first_semester_start + i.days,
    admin_user: admin_user,
    post_type: :announcement,
    severity: :high,
    source: :vc_office,
    sender_name: sender_details[:vc_office][:name],
    sender_title: sender_details[:vc_office][:title]
  )
end

Event.create!(
  title: "New Student Orientation",
  details: "A mandatory orientation program for all newly admitted students.",
  start_date: first_semester_start + 1.week,
  admin_user: admin_user,
  event_type: "event"
)

# Registration and Fee Payment (First month)
10.times do |i|
  Post.create!(
    title: "Reminder: Course Registration Deadline Approaching",
    summary: "This is a reminder that the portal for course registration will close soon. Please complete your registration to avoid any issues.",
    content: "All students are reminded that the course registration portal for the first semester will close on #{first_semester_start + 1.month}. There will be no extension of this deadline. Please ensure you have registered all your courses and paid the necessary fees.",
    status: :published,
    published_at: first_semester_start + i.days * 2,
    admin_user: admin_user,
    post_type: :memo,
    severity: :high,
    source: :registrar,
    sender_name: sender_details[:registrar][:name],
    sender_title: sender_details[:registrar][:title]
  )
end

Event.create!(
  title: "Deadline for Fee Payment",
  details: "All students must pay their school fees on or before this date.",
  start_date: first_semester_start + 1.month,
  admin_user: admin_user,
  event_type: "deadline"
)

# Mid-Semester Activities
20.times do |i|
  Post.create!(
    title: "Academic Workshop Series: #{[ 'Engineering', 'Sciences', 'Arts' ].sample}",
    summary: "Join us for a series of academic workshops designed to enhance your learning experience.",
    content: "The academic planning unit is organizing a series of workshops on various topics. These workshops are open to all students and are designed to provide additional academic support. The schedule will be released shortly.",
    status: :published,
    published_at: first_semester_start + 2.months + i.days,
    admin_user: admin_user,
    post_type: :announcement,
    severity: :medium,
    source: :dean_of_students,
    sender_name: sender_details[:dean_of_students][:name],
    sender_title: sender_details[:dean_of_students][:title]
  )
end

# Examinations
15.times do |i|
  Post.create!(
    title: "First Semester Examination Timetable",
    summary: "The final timetable for the first semester examinations is now available. Please check the university portal for details.",
    content: "The final examination timetable for the first semester is now available on the university portal. Students are advised to download the timetable and check for any clashes. Any issues should be reported to the examinations and records office before #{first_semester_end - 2.weeks}.",
    status: :published,
    published_at: first_semester_end - 1.month + i.days,
    admin_user: admin_user,
    post_type: :memo,
    severity: :high,
    source: :registrar,
    sender_name: sender_details[:registrar][:name],
    sender_title: sender_details[:registrar][:title]
  )
end

Event.create!(
  title: "First Semester Examinations",
  details: "The first semester examinations will hold from #{first_semester_end - 2.weeks} to #{first_semester_end}.",
  start_date: first_semester_end - 2.weeks,
  end_date: first_semester_end,
  admin_user: admin_user,
  event_type: "event"
)

# --- SEMESTER BREAK ---

10.times do |i|
  Post.create!(
    title: "Release of First Semester Results",
    summary: "The results for the first semester examinations have been approved by the Senate and are now available on the university portal.",
    content: "Students can now check their results for the first semester examinations on the university portal. If you have any complaints, please follow the official procedure for result verification.",
    status: :published,
    published_at: first_semester_end + 2.weeks + i.days,
    admin_user: admin_user,
    post_type: :announcement,
    severity: :high,
    source: :registrar,
    sender_name: sender_details[:registrar][:name],
    sender_title: sender_details[:registrar][:title]
  )
end

# --- SECOND SEMESTER ---

# Resumption and Registration
15.times do |i|
  Post.create!(
    title: "Second Semester Resumption and Registration",
    summary: "The university will resume for the second semester on #{second_semester_start}. The registration portal will be open for two weeks.",
    content: "All students are expected to resume for the second semester on #{second_semester_start}. The portal for course registration will be open from #{second_semester_start} to #{second_semester_start + 2.weeks}. We wish you a successful semester.",
    status: :published,
    published_at: second_semester_start - 2.weeks + i.days,
    admin_user: admin_user,
    post_type: :announcement,
    severity: :high,
    source: :registrar,
    sender_name: sender_details[:registrar][:name],
    sender_title: sender_details[:registrar][:title]
  )
end

# General Announcements and Memos
30.times do |i|
  source = Post.sources.keys.sample
  details = sender_details[source.to_sym]

  Post.create!(
    title: "General Notice from the #{source.to_s.humanize}",
    summary: "An important notice from the #{source.to_s.humanize}. All students and staff are to take note.",
    content: "This is a general notice from the #{source.to_s.humanize}. We wish to inform the university community about [Topic]. Further details will be communicated in due course. Thank you for your cooperation.",
    status: :published,
    published_at: today - 3.months + i.days * 3,
    admin_user: admin_user,
    post_type: :memo,
    severity: [ :low, :medium ].sample,
    source: source,
    sender_name: details[:name],
    sender_title: details[:title]
  )
end

# --- UPCOMING EVENTS (Generated) ---

25.times do |i|
  Event.create!(
    title: "Upcoming Workshop: #{[ 'Career Development', 'Public Speaking', 'Entrepreneurship' ].sample}",
    details: "A workshop to equip students with essential skills for the future.",
    start_date: today + i.weeks,
    admin_user: admin_user,
    event_type: "event"
  )
end

25.times do |i|
  Event.create!(
    title: "Deadline: #{[ 'Scholarship Application', 'Hostel Accommodation Request', 'Final Year Project Submission' ].sample}",
    details: "Please take note of this important deadline.",
    start_date: today + i.weeks,
    admin_user: admin_user,
    event_type: "deadline"
  )
end
