class Api::V1::StocksController < Api::V1::ApplicationController
  def index
    call_action(Api::V1::Stocks::Index::Action.new, {})
  end

  def create
    call_action(Api::V1::Stocks::Create::Action.new, new_stock_params.to_h)
  end

  def update
    call_action(Api::V1::Stocks::Update::Action.new, stock_params.to_h)
  end

  def update_bearer
    call_action(Api::V1::Stocks::UpdateBearer::Action.new, bearer_params.to_h)
  end

  def destroy
    call_action(Api::V1::Stocks::Destroy::Action, { id: params[:id] })
  end

  private
  def new_stock_params
    params.permit(:name, bearer: [:name])
  end

  def bearer_params
    params.permit(:id, bearer: [:name])
  end

  def stock_params
    params.permit(:id, :name)
  end
end
