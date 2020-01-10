require 'rails_helper'

RSpec.describe PricingsController, type: :controller do

  describe "GET #get data" do
    it "should get data based on region" do
      data_count = Pricing.with_dimensions.where(region: 'us-east-1').size
      get :price_dimension, params: { region: 'us-east-1' }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).count).to eq data_count
    end

    it "should get data based on future date" do
      get :price_dimension, params: {region: 'us-east-1', date: (Time.current.utc + 1.day).to_date }
      expect(response).to have_http_status(:ok)
      expect(response.body).to eq "[]"
    end

    it "should get data based on date" do
      date = Date.today
      data_count = Pricing.with_dimensions.where("DATE(effective_date) = ?", date).size
      get :price_dimension, params: { region: 'us-east-1', date: date }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).length).to eq data_count
    end

    it "should get data based on both region and date" do
      date = Date.today
      data_count = Pricing.with_dimensions.where("region = ? AND DATE(effective_date) = ?", 'us-east-1', date).size
      get :price_dimension, params: { region: 'us-east-1', date: date }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).length).to eq data_count
    end
  end

  describe "POST #create pricings" do
    it "should create pricing" do
      pricing_count = Pricing.count
      post :create, params: { pricing: { sku: 'CYHNW9MJYBF8UUJY', effective_date: '2019-12-09 00:00:00', region: 'us-east-1' } }, format: :json
      expect(response).to have_http_status(:created)
      expect(Pricing.count).to eq (pricing_count + 1)
    end
  end
end
