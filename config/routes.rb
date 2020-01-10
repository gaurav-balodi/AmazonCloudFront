Rails.application.routes.draw do
  resources :pricings, only: :create do
  	member do
  	  resources :price_dimensions, only: :create
  	end
  end

  get 'service/AmazonCloudFront/region/:region' => 'pricings#price_dimension'

  # To handle any unwanted routes posing issues such as: when favicon is not present
  get '*other' => 'application#static'
end
