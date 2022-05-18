require 'dry/matcher/result_matcher'

class Api::V1::Stocks::UpdateBearer::Action
  include Dry::Monads[:do, :result]
  include Dry::Matcher.for(:call, with: Dry::Matcher::ResultMatcher)

  def call(params)
    valid_params = yield validate(params)
    valid_params = valid_params.to_h

    stock = yield find(valid_params[:id])
    valid_params[:name] = stock.name

    yield delete(stock)
    stock = yield create(valid_params)

    Success(stock)
  end

  private
  def validate(params)
    Api::V1::Stocks::UpdateBearer::Validator.new.call(params)
  end

  def find(id)
    stock = ::Stock.find(id)

    Success(stock)
  end

  def delete(stock)
    stock.destroy!

    Success(true)
  end

  def create(params)
    Api::V1::Stocks::Creator.call(params)
  end
end

