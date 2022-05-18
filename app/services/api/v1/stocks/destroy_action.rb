require 'dry/matcher/result_matcher'

class Api::V1::Stocks::DestroyAction
  extend Dry::Initializer
  include Dry::Monads[:do, :result]
  include Dry.Types

  option :id, type: proc(&:to_i)

  def self.call(args)
    new(**args).call
  end

  def call
    stock = yield delete(id)

    Success(stock)
  end

  private
  def delete(id)
    stock = ::Stock.find(id)
    stock.soft_delete!

    Success(stock)
  end
end

