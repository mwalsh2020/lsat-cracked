if Rails.env.development?
  Bullet.enable = true
  Bullet.console = true
  Bullet.add_footer = true
end
