require 'net/http'

class AmazonCloudFront
  CLOUDFRONT_PRICING_URI = 'https://pricing.us-east-1.amazonaws.com/offers/v1.0/aws/AmazonCloudFront/current/index.json'
  ALLOWED_KEYS = %w(sku effectiveDate description beginRange endRange unit USD)

  class << self
    def scrape_pricing
      begin
        cloudfront_prices = JSON.parse(Net::HTTP.get(URI.parse(CLOUDFRONT_PRICING_URI)))
        pricing_details = fetch_hash_objects(cloudfront_prices.dig('terms', 'OnDemand'))

        pricing_details.each_with_index do |price_dimension, i|
          next unless price_dimension.keys.include?(:sku)
          pricing = Pricing.find_or_initialize_by(sku: price_dimension[:sku], effective_date: pricing_details[i + 1][:effectiveDate])
          pricing.region = 'us-east-1'
          pricing.assign_attributes(price_dimensions_attributes: [{description: pricing_details[i + 2][:description], begin_range: pricing_details[i + 3][:beginRange], end_range: pricing_details[i + 4][:endRange], unit: pricing_details[i + 5][:unit], price_per_unit: pricing_details[i + 6][:USD]}])
          pricing.save
        end
      # Setting rescue to default Standard Error
      rescue => exception
        Rails.logger.warn "Unable to save the CloudFront pricing with reason: #{exception.message}, #{exception.backtrace.first(20)}"
      end
    end

    # Fetching and generating collection of hash recursively
    def fetch_hash_objects(h)
      price_dimensions = []
      h.each_pair do |k, v|
        if v.is_a?(Hash)
          price_dimensions << fetch_hash_objects(v)
        else
          price_dimensions << {"#{k}": v} if ALLOWED_KEYS.include?(k)
        end
      end
      price_dimensions.flatten
    end
  end
end
