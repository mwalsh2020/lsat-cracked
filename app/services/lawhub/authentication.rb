class Lawhub::Authentication
  attr_reader :credentials, :url, :body, :headers

  def initialize
    @credentials = Lawhub.credentials
    @url = "https://login.microsoftonline.com/#{Lawhub.config.tenant_id}/oauth2/v2.0/token"
    @body = {
      grant_type: "client_credentials",
      scope: Lawhub.config.scope
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
    Rails.cache.fetch({lawhub: :access_token}, expires_in: 59.minutes) { request["access_token"] }
  end

  private

  def request
    @request ||= HTTParty.post(url, body: body, headers: headers)
  end
end
