namespace :user do
  desc "Ping LSAC for users logged in since last day (async)"
  task ping_lsac_login: :environment do
    recent_users = User.where("last_sign_in_at < ?", 1.day.ago.beginning_of_day).where(prep_plus: true)
    recent_users_ids = recent_users.pluck(:id)
    puts "Enqueuing LSAC ping for recently active users."
    recent_users_ids.each do |user_id|
      PingLsacJob.perform_now(user_id)
    end
  end
end
