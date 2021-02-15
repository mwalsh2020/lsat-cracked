namespace :user do
  desc "Ping LSAC for users logged in this week (async)"
  task ping_lsac_login: :environment do
    recent_users = User.where("last_sign_in_at < ?", 7.days.ago).where(prep_plus: true)
    puts "Enqueuing LSAC ping for recently active users."
    recent_users.find_each do |user|
      PingLsacJob.perform_now(user)
    end
  end
end
