require "faker"

puts "Creating users..."
users = {
  free:     User.create!(email: "free@user.com",     password: "123456", paying: false, admin: true,  prep_plus: false),
  user:     User.create!(email: "user@user.com",     password: "123456", paying: true,  admin: false, prep_plus: true ),
  paying:   User.create!(email: "paying@user.com",   password: "123456", paying: true,  admin: false, prep_plus: true ),
  admin:    User.create!(email: "admin@user.com",    password: "123456", paying: true,  admin: true,  prep_plus: true ),
  frequent: User.create!(email: "frequent@user.com", password: "123456", paying: true,  admin: true,  prep_plus: true ),
}

puts "Creating premium tags..."
Tag.create!(slug: "lsat-premium", premium: true)

puts "Importing book content..."
Rake::Task["db:seed:course_content"].invoke

puts "Creating products..."
Product.create!(
  name: "Basic",
  sku: "package-1",
  description: "<ul><li>1 Coaching Session</li><li>LSAT Cracked Book</li></ul>",
  price: 695,
  full_price: 925,
)

Product.create!(
  name: "Premium",
  sku: "package-2",
  description: "<ul><li>3 Coaching Sessions</li><li>Private weekly office hours</li><li>LSAT Cracked Book</li><li>Customized study plan</li></ul>",
  price: 2395,
  full_price: 3300,
)

Product.create!(
  name: "Ultimate",
  sku: "package-3",
  description: "<ul><li>10 Coaching Sessions</li><li>Private weekly office hours</li><li>LSAT Cracked Book</li><li>Customized study plan</li></ul>",
  price: 6295,
  full_price: 8550,
)

puts "Creating extra random seeds..."
tags = 8.times.map do
  Tag.create!(slug: Faker::Games::DnD.unique.language.parameterize)
end

puts "Assigning extra tags..."
Question.find_each { |question| question.tags << tags.sample(2) }

puts "Creating intro article..."
Article.create!(title: "Intro", intro: true)



puts "Anwering questions for frequent user..."
Section.with_questions.each do |section|
  quiz = QuizBuilder.new(quizable: section, user: users[:frequent]).build_and_save
  quiz.quiz_questions.includes(:possible_answers).each do |qq|
    variance_constant = 5

    # This generates a proficiency value foro the user in the given tag based on
    # the highest tag index
    tag_proficiency = tags.map {|tag| tags.index(tag) }.max

    # The following generates "tag_proficiency" times more correct than wrong answers
    generated_answers = (
      Array.new(variance_constant * tag_proficiency) {qq.possible_answers.correct} +
      Array.new(variance_constant)                   {qq.possible_answers.wrong}
    ).flatten

    qq.update(answer: generated_answers.sample)
  end
end
