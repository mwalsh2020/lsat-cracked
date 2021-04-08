module QuotesHelper
  def quote_of_the_day
    QuoteFetcher.quote_of_the_day
  end
end
