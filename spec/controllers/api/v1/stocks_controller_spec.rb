require 'rails_helper'

RSpec.describe Api::V1::StocksController, type: :controller do
  describe "create" do
    it "creates stock" do
      params = { name: "New Stock", bearer: { name: "New Bearer" }}
      post :create, params: params, format: :json

      expect(response).to have_http_status(:success)

      stock = ::Stock.find_by_name(params[:name])
      expect(stock.bearer.name).to be_eql(params[:bearer][:name])
    end

    it "returns error when name is missed" do
      params = { bearer: { name: "New Bearer" }}
      post :create, format: :json

      expect(response).to have_http_status(:bad_request)
      expect(response.body).to include_json(errors: { name: ["is missing"] })
    end

    it "returns error when bearer is missed" do
      params = { name: "New Stock" }
      post :create, format: :json

      expect(response).to have_http_status(:bad_request)
      expect(response.body).to include_json(errors: { bearer: ["is missing"] })
    end
  end


  describe "update" do
    let(:stock) { create(:stock, name: "Old Name") }

    it "updates stock" do
      params = { id: stock.id, name: "New Stock" }
      expect {
        put :update, params: params, format: :json
      }.to change{ stock.reload.name }.to(params[:name])

      expect(response).to have_http_status(:success)
    end

    it "ignores bearer" do
      params = { id: stock.id, name: "New Stock", bearer: { name: "New Bearer" } }
      expect {
        put :update, params: params, format: :json
      }.to_not change{ stock.bearer.reload.name }

      expect(response).to have_http_status(:success)
    end
  end

  describe "index" do
    it "returns list of stocks and bearers except deleted" do
      stock_1, stock_2 = create_list(:stock, 2)
      create(:stock, state: ::Stock::DELETED)

      get :index, format: :json

      expect(response).to have_http_status(:success)
      expect(response.body).to include_json([
        { name: stock_1.name, bearer: { name: stock_1.bearer.name } },
        { name: stock_2.name, bearer: { name: stock_2.bearer.name } }
      ])
    end
  end

  describe "delete" do
    it "deletes stock softly" do
      stock = create(:stock, state: ::Stock::PUBLISHED)
      params = { id: stock.id }
      expect {
        delete :destroy, params: params, format: :json
      }.to change { stock.reload.state }.to(::Stock::DELETED)

      expect(response).to have_http_status(:success)
    end
  end

  describe "update_bearer" do
    it "updates stock's bearer when bearer is new" do
      bearer = create(:bearer, name: "Old Bearer")
      stock = create(:stock, bearer: bearer)

      params = { id: stock.id, bearer: { name: "New Bearer" } }
      put :update_bearer, params: params, format: :json

      expect(response).to have_http_status(:success)

      stock = ::Stock.find_by_name(stock.name)
      expect(stock.bearer.name).to be_eql(params[:bearer][:name])
    end

    it "updates stock's bearer when bearer already existed" do
      bearer = create(:bearer, name: "New Bearer")
      stock = create(:stock)

      params = { id: stock.id, bearer: { name: "New Bearer" } }
      put :update_bearer, params: params, format: :json

      expect(response).to have_http_status(:success)

      stock = ::Stock.find_by_name(stock.name)
      expect(stock.bearer.name).to be_eql(params[:bearer][:name])
    end
  end
end
