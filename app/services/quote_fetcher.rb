class QuoteFetcher
  include Executable

  class Quote < OpenStruct
    def author
      super || "Anonymous"
    end
  end

  def self.quote_of_the_day
    data = Rails.cache.fetch(:cached_quote, expires_in: 24.hours) do
      execute
    end
    Quote.new(data)
  end

  def execute
    JSON.parse(fetch_quotes).sample
  rescue
    default_quote_data
  end

  private

  def fetch_quotes
    HTTParty.get("https://type.fit/api/quotes")
  end

  def default_quote_data
    {
      text: "The truest wisdom is a resolute determination.",
      author: "Napoleon Bonaparte"
    }
  end
end
