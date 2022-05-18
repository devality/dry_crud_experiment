require 'dry/matcher/result_matcher'

class Api::V1::Stocks::Create::Action
  include Dry::Monads[:do, :result]
  include Dry::Matcher.for(:call, with: Dry::Matcher::ResultMatcher)

  def call(params)
    valid_params = yield validate(params)
    stock = yield create(valid_params.to_h)

    Success(stock)
  end

  private
  def validate(params)
    Api::V1::Stocks::Create::Validator.new.call(params)
  end

  def create(params)
    Api::V1::Stocks::Create::Creator.call(params)
  end
end

