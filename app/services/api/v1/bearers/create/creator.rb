class Api::V1::Bearers::Create::Creator
  extend Dry::Initializer
  include Dry::Monads[:do, :result]
  include Dry.Types

  option :name, type: Strict::String

  def self.call(args)
    new(**args).call
  end

  def call
    bearer = yield create(name)

    Success(bearer)
  end

  private

  def create(name)
    bearer = ::Bearer.create!({
      name: name
    })

    Success(bearer)
  end
end

