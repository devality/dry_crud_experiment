module StockStateMachine
  extend ActiveSupport::Concern

  included do
    state_machine :state, initial: :published do
      state :publised
      state :deleted

      event :soft_delete do
        transition published: :deleted
      end

      event :publish do
        transition deleted: :published
      end
    end
  end
end

