class Api::V1::StocksController < Api::V1::ApplicationController
  def index
    call_action(Api::V1::Stocks::IndexAction.new, {})
  end

  def create
    call_action(Api::V1::Stocks::CreateAction.new, new_stock_params.to_h)
  end

  def update
    call_action(Api::V1::Stocks::UpdateAction.new, stock_params.to_h)
  end


  private
  def new_stock_params
    params.permit(:name, bearer: [:name])
  end

  def stock_params
    params.permit(:id, :name)
  end
end
