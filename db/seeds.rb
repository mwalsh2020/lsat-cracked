puts "Creating users..."
user_params = [
  { email: "free_user@user.com", password: "123456", paying: false, admin: true },
  { email: "user@user.com",      password: "123456", paying: true,  admin: false },
  { email: "admin@user.com",     password: "123456", paying: true,  admin: true },
]
User.create!(user_params)

puts "Creating premium tags..."
Tag.create!(slug: "lsat-premium", premium: true)

puts "Importing book content..."
Rake::Task["db:seed:course_content"].invoke

puts "Creating products..."
Product.create!(
  name: "Basic",
  sku: "package-1",
  description: "<ul><li>1 Coaching Session</li><li>3 private seminars included</li><li>LSAT Cracked Book</li></ul>",
  price: 695,
  full_price: 925,
)

Product.create!(
  name: "Premium",
  sku: "package-2",
  description: "<ul><li>3 Coaching Sessions</li><li>10 private seminars included</li><li>LSAT Cracked Book</li><li>Customized study plan</li></ul>",
  price: 2395,
  full_price: 3300,
)

Product.create!(
  name: "Ultimate",
  sku: "package-3",
  description: "<ul><li>10 Coaching Sessions</li><li>20 private seminars included</li><li>LSAT Cracked Book</li><li>Customized study plan</li></ul>",
  price: 6295,
  full_price: 8550,
)
