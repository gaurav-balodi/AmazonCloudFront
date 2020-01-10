require 'rails_helper'

RSpec.describe Pricing, type: :model do  
  subject {
    described_class.new(sku: "RN2BPS8XT2GYJ4UF", region: 'us-east-1', effective_date: DateTime.current)
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a sku" do
    subject.sku = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a region" do
    subject.region = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a effective_date" do
    subject.effective_date = nil
    expect(subject).to_not be_valid
  end

  it "is not valid if sku is not unique with region and effective_date" do
    pricing = described_class.new(sku: "RN2BPS8XT2GYJ4UF", region: 'us-east-1', effective_date: subject.effective_date)
    pricing.save
    expect(subject).to_not be_valid
  end
end
