class Api::V1::Stocks::CreateValidator < Dry::Validation::Contract
  params do
    required(:name).filled(:string)
    required(:bearer).hash do
      required(:name).filled(:string)
    end
  end
end

