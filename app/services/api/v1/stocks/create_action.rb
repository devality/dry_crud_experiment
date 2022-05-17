require 'dry/matcher/result_matcher'

class Api::V1::Stocks::CreateAction
  include Dry::Monads[:do, :result]
  include Dry::Matcher.for(:call, with: Dry::Matcher::ResultMatcher)

  def call(params)
    valid_params = yield validate(params)
    stock = yield create(valid_params.to_h)

    Success(stock)
  end

  private
  def validate(params)
    Api::V1::Stocks::CreateValidator.new.call(params)
  end

  def create(params)
    Api::V1::Stocks::Creator.call(params)
  end
end

