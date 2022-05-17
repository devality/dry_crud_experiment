require 'dry/matcher/result_matcher'

class Actions::Api::V1::Stocks::CreateAction < Actions::BaseAction
  include Dry::Monads[:do, :result]
  include Dry::Matcher.for(:call, with: Dry::Matcher::ResultMatcher)

  def self.call(*args)
    new.call(*args)
  end

  private
  def call(params)
    valid_params = yield validate(params)
    stock = yield create(valid_params.to_h)

    Success(stock)
  end

  def validate(params)
    Api::V1::Stocks::CreateValidator.new.call(params)
  end

  def create(params)
    Api::V1::StockCreator.call(params)
  end
end

