namespace :user do
  desc "Ping LSAC for users logged in this week (async)"
  task ping_lsac_login: :environment do
    recent_users = User.find_each.select do |user|
      login_this_week?(user)
    end
    p "Enqueuing LSAC ping for recently active users."
    recent_users.each do |user|
      PingLsacJob.perform_now(user)
    end
  end

  def login_this_week?(user)
    user.last_sign_in_at && user.last_sign_in_at.to_date < 7.days.ago.to_date
  end
end
