require 'rails_helper'

RSpec.describe Api::V1::StocksController, type: :controller do
  it "creates stock" do
    params = { name: "New Stock"}
    post :create, params: params

    expect(response).to have_http_status(:success)
  end

  it "return error when name is missed" do
    post :create

    expect(response).to have_http_status(:unprocessable_entity)
  end
end
