require 'rails_helper'

RSpec.describe PriceDimensionsController, type: :controller do

  before(:each) do
    @pricing = FactoryGirl.create(:pricing)
  end

  describe "POST #create price dimension" do
    it "should create pricing" do
      pricing_dimension_count = PriceDimension.count
      post :create, params: {
        id: @pricing.id,
        price_dimension: { description: "$6.0E-7  per Request for Lambda-Edge-Request in EU (Paris)", begin_range: 0, end_range: 1, unit: "Lambda-GB-Second", price_per_unit: "0.0000500100" }}, format: :json
      expect(response).to have_http_status(:created)
      expect(PriceDimension.count).to eq (pricing_dimension_count + 1)
    end
  end
end
