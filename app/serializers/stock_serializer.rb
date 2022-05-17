class StockSerializer < ActiveModel::Serializer
  attributes :name
  belongs_to :bearer, serializer: BearerSerializer
end

