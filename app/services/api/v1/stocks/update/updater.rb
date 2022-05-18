class Api::V1::Stocks::Update::Updater
  extend Dry::Initializer
  include Dry::Monads[:do, :result]
  include Dry.Types

  option :id, type: Strict::Integer
  option :name, type: Strict::String

  def self.call(args)
    new(**args).call
  end

  def call
    stock = ::Stock.find_by_id(id)
    if stock
      stock.name = name
      stock.save!

      Success(stock)
    else
      Failure(:stock_not_found)
    end
  end
end

