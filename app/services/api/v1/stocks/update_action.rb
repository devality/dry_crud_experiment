require 'dry/matcher/result_matcher'

class Api::V1::Stocks::UpdateAction
  include Dry::Monads[:do, :result]
  include Dry::Matcher.for(:call, with: Dry::Matcher::ResultMatcher)

  def call(params)
    valid_params = yield validate(params)
    stock = yield update(valid_params.to_h)

    Success(stock)
  end

  private
  def validate(params)
    Api::V1::Stocks::UpdateValidator.new.call(params)
  end

  def update(params)
    Api::V1::Stocks::Updater.call(params)
  end
end

