class ApplicationController < ActionController::API

  def call_action(action, params)
    action.call(params) do |result|
      result.success do |result|
        respond_with result
      end

      result.failure(Dry::Validation::Result) do |result|
        respond_with errors: result.errors.to_h
      end

      result.failure do
        head :server_error
      end
    end
  end
end
