module StocksRepository
  extend ActiveSupport::Concern

  included do
    scope :published, ->() { where(state: ::Stock::PUBLISHED) }
  end
end
