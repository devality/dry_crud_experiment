class Api::V1::Stocks::CreateAction < BaseAction
  include Dry::Monads[:result]

  def self.call(args)
    new(**args).call
  end

  private
  def call
  end
end

