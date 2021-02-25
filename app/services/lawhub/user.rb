class Lawhub::User
  include HTTParty
  base_uri "https://lsac-apim.azure-api.net/#{Lawhub.config.endpoint_vendor}/api/vendor/#{Lawhub.config.vendor}"

  attr_reader :user

  def initialize(user, opts = {})
    @user = user
  end

  def login
    self.class.post(
      "/log",
      body: default_body("type": "login", "emailAddress": user.email),
      headers: default_headers
    )
  end

  private

  def default_headers
    {
      "Content-Type": "application/json",
      "Authorization": access_token
    }
  end

  def default_body(params = {})
    {"source": Lawhub.config.vendor}.merge(params).to_json
  end

  def access_token
    Lawhub::Authentication.access_token
  end
end
