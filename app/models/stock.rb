class Stock < ApplicationRecord
  extend Enumerize
  include StocksRepository
  include StockStateMachine

  PUBLISHED = 'published'.freeze
  DELETED = 'deleted'.freeze

  belongs_to :bearer

  enumerize :state, in: [PUBLISHED, DELETED]
end
