if Rails.env.development?
  Rails.application.configure do
    config.hosts.clear
  end
end
