class Api::V1::Stocks::UpdateValidator < Dry::Validation::Contract
  params do
    required(:name).filled(:string)
  end
end

