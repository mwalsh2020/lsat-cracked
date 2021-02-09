class CheckLoginTimesJob < ApplicationJob
  queue_as :default

  def perform
    p "We're checking the users to see when they last logged in."
    recent_users = User.find_each.select do |user|
      login_this_week?(user)
    end
    recent_users.each do |user|
      p "#{user.email} logged in this week."
      ping_lsac(user)
    end
  end

  def login_this_week?(user)
    user.last_sign_in_at && user.last_sign_in_at.to_date < 7.days.ago.to_date
  end

  def ping_lsac(user)
    service = Lawhub::User.new(user)
    service.login
  end
end
