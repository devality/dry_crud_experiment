FactoryBot.define do
  factory :stock do
    name { "stock_#{SecureRandom.hex(5)}"}
    state { ::Stock::PUBLISHED }
    bearer
  end
end

