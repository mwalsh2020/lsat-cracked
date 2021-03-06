class PingLsacJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    @user = User.find(user_id)
    puts "#{@user.email} logged in this week."
    ping_lsac
  end

  private

  def ping_lsac
    service = Lawhub::User.new(@user)
    service.login
  end
end
