puts "Creating users..."
user_params = [
  { email: "free_user@user.com", password: "123456", paying: false, admin: true },
  { email: "user@user.com",      password: "123456", paying: true,  admin: false },
  { email: "admin@user.com",     password: "123456", paying: true,  admin: true },
]
User.create!(user_params)

puts "Importing book content..."
Rake::Task["db:seed:course_content"].invoke
