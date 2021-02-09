class CheckLoginTimesJob < ApplicationJob
  queue_as :default

  def perform
    logged_in = []
    p "We're checking the users to see when they last logged in."
    User.all.each do |user|
      sign_in_date = user.last_sign_in_at ? user.last_sign_in_at.to_date : nil
      week_ago = 7.days.ago.to_date
      if sign_in_date && sign_in_date < week_ago
        p "#{user.email} logged in this week."
        login(user)
      end
    end
    p "We pinged LSAC for these users: #{logged_in}"
  end

  def login(user)
    service = Lawhub::User.new(user)
    service.login
  end
end
