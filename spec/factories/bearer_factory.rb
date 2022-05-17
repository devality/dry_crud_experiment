FactoryBot.define do
  factory :bearer do
    name { "bearer_#{SecureRandom.hex(5)}"}
  end
end

