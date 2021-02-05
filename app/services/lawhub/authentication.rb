class Lawhub::Authentication
  attr_reader :credentials, :url, :body, :headers

  def initialize
    @credentials = Lawhub.credentials
    @url = "https://login.microsoftonline.com/#{Lawhub.config.tenant_id}/oauth2/v2.0/token"
    @scope = "https://lawpathb2b.onmicrosoft.com/06b7d783-8a46-43de-a375-07059967cb3b/.default"
    @body = {
      grant_type: "client_credentials",
      scope: @scope
    }
    @headers = {
      "Authorization" => "Basic #{credentials}",
      "Content-Type" => "application/x-www-form-urlencoded;charset=UTF-8"
    }
  end

  def self.access_token
    self.new.access_token
  end

  def access_token
    r = HTTParty.post(url, body: body, headers: headers)
    {response: r, token: JSON.parse(r.body)['access_token']}
  end
end
