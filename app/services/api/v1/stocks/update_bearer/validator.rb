class Api::V1::Stocks::UpdateBearer::Validator < Dry::Validation::Contract
  params do
    required(:id).filled(:integer)
    required(:bearer).hash do
      required(:name).filled(:string)
    end
  end
end

