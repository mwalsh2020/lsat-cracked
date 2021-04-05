require 'httparty'
require 'json'

class QuoteFetcher
  include Executable

  def initialize; end

  def execute
    response = JSON.parse(fetch_quotes)
  end

  private

  def fetch_quotes
    response = HTTParty.get("https://type.fit/api/quotes")
  end
end