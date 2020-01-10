# README

This application contains the following Amazon CloudFront assignment:-

1. Create a Rails API app with any database of your choice 
2. Fetch the Amazon CLoudFront On-Demand pricing from this API 
   https://pricing.us-east-1.amazonaws.com/offers/v1.0/aws/AmazonCloudFront/current/index.json 
3. Store it in the DB This is done daily at Midnight The old pricing data should be preserved 
4. Create the following JSON API: 
   a. Request 
      -> API to view pricing for a specific region 
         GET /service/AmazonCloudFront/region/us-east-1 
      -> It should have the ability to filter data according to the date specified 
         GET /service/AmazonCloudFront/region/us-east-1?date=<DATE> 
   b. Response 
	  [
		{
		    "description": "$0.085 per GB - first 10 TB / month data transfer out (Canada)",
		    "beginRange": 0,
		    "endRange": 10240,
		    "unit": "GB",
		    "pricePerUnit": "0.0850000000",
		    "effectiveDate": "2018-09-01T00:00:00Z"
		},
		{
		    "description": "$0.080 per GB - next 40 TB / month data transfer out (Canada)",
		    "beginRange": 10240,
		    "endRange": 51200,
		    "unit": "GB",
		    "pricePerUnit": "0.0850000000",
		    "effectiveDate": "2018-09-01T00:00:00Z"
		}
	  ]
4. Write Rspec 
5. Use Object Oriented principles & make the code as modular as possible 
6. Make it so that I can add pricing for more services when needed 

####################################################################################
1. This application is using postgresql as database. Please create your database using the following command

  rails db:create db:migrate 

NOTE: Please do change your postgres password on database.yml before proceeding.

2. Rake Task has been created to fetch the Amazon Pricing using cronjob

   rails amazon:scrape_pricing

   To set cronjob on server execute the following command

	 whenever --update-crontab

2. Test written in rspec, please use the following command to run rspec test.

   RAILS_ENV=test bundle exec rspec

3. There are 2 APIs for creating new pricing for more services. The steps are as follows:

   a. POST pricings with the following parameters format
      {
        "pricing": 
        {
        	"sku": "",
        	"region": "",
        	"effective_date": ""
        }
      }
    b. POST pricings/:pricing_id/price_dimensions with the following paramters format
	  
	    {
        "price_dimension": 
        {
        	"description": "",
        	"begin_range": "",
        	"end_range": "",
        	"unit": "",
        	"price_per_unit": ""
        }
      }
