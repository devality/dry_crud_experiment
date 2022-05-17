class Api::V1::StocksController < Api::V1::ApplicationController
  def create
    respond_with Actions::Api::V1::Stocks::CreateAction.call(stock_params)
  end

  private
  def stock_params
    params.permit(:name, bearer: [:name])
  end
end
