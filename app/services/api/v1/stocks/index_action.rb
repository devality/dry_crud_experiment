require 'dry/matcher/result_matcher'

class Api::V1::Stocks::IndexAction
  include Dry::Monads[:do, :result]
  include Dry::Matcher.for(:call, with: Dry::Matcher::ResultMatcher)

  def call(_params)
    stocks = ::Stock.published.sort_by(&:created_at)

    Success(stocks)
  end
end

