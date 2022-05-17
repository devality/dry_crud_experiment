class Api::V1::StockCreator
  extend Dry::Initializer
  include Dry::Monads[:result]
  include Dry.Types

  option :name, type: Strict::String
  option :bearer do
    option :name, type: Strict::String
  end

  def self.call(args)
    new(**args).call
  end

  private
  def call
    bearer = find_or_create_bearer(bearer.name)

    stock = Stock.create!({
      name: name,
      state: Stock::PUBLISHED,
      bearer: bearer
    })

    Success(stock)
  end

  def find_or_create_bearer(bearer_name)
    bearer = Bearer.find_by_name(bearer_name)
  end
end

