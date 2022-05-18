class Api::V1::Stocks::UpdateBearer::Updater
  extend Dry::Initializer
  include Dry::Monads[:do, :result]
  include Dry.Types

  option :id, type: Strict::Integer
  option :bearer do
    option :name, type: Strict::String
  end

  def self.call(args)
    new(**args).call
  end

  def call
    stock = yield find(id)
    params = {
      name: stock.name,
      bearer: {
        name: bearer.name
      }
    }

    yield delete(stock)
    stock = yield create(params)

    Success(stock)
  end

  private
  def find(id)
    stock = ::Stock.find(id)

    Success(stock)
  end

  def delete(stock)
    stock.destroy!

    Success(true)
  end

  def create(params)
    Api::V1::Stocks::Create::Creator.call(params)
  end
end

