class Api::V1::Stocks::Creator
  extend Dry::Initializer
  include Dry::Monads[:do, :result]
  include Dry.Types

  option :name, type: Strict::String
  option :bearer do
    option :name, type: Strict::String
  end

  def self.call(args)
    new(**args).call
  end

  def call
    needed_bearer = yield find_or_create_bearer(bearer.name)
    stock = yield create(name, needed_bearer)

    Success(stock)
  end

  private
  def find_or_create_bearer(bearer_name)
    bearer = ::Bearer.find_by_name(bearer_name)
    bearer ||= Api::V1::Bearers::Creator.call(name: bearer_name).value_or(nil)

    Success(bearer)
  end

  def create(name, bearer)
    stock = ::Stock.create!({
      name: name,
      state: ::Stock::PUBLISHED,
      bearer: bearer
    })

    Success(stock)
  end
end

