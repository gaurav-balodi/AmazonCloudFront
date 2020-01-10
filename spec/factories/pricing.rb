FactoryGirl.define do
  factory :pricing do |price|
    price.sku "CYHNW9MJYBF8UUJY#{Time.current.to_i}"
    price.effective_date "2019-12-01 00:00:00"
    price.region "us-east-1"
  end
end
