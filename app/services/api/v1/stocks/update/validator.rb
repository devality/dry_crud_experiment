class Api::V1::Stocks::Update::Validator < Dry::Validation::Contract
  params do
    required(:id).filled(:integer)
    required(:name).filled(:string)
  end
end

