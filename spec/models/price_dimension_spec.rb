require 'rails_helper'

RSpec.describe PriceDimension, type: :model do
  subject {
    pricing = FactoryGirl.create(:pricing)
    described_class.new(description: "$6.0E-7  per Request for Lambda-Edge-Request in AWS GovCloud (US-East)", begin_range: 0, end_range: 0, unit: "Request", price_per_unit: 0.0000006, pricing_id: pricing.id)
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a sku" do
    subject.pricing_id = nil
    expect(subject).to_not be_valid
  end
end
