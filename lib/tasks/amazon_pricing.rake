namespace :amazon do
  desc "This rake task calls the AmazonCloudFront service to scrape pricing"
  task scrape_pricing: :environment do
    AmazonCloudFront.scrape_pricing
  end
end
