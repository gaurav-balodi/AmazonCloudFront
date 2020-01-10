class PriceDimensionsController < ApplicationController
  before_action :set_pricing, only: :create

  def create
    price_dimension = @pricing.price_dimensions.build(permit_params)
    if price_dimension.save
      render json: price_dimension, status: :created
    else
      render json: { errors: price_dimension.errors }, status: :unprocessable_entity
    end
  end

  private

  def permit_params
  	params.require(:price_dimension).permit(:description, :begin_range, :end_range, :unit, :price_per_unit)
  end

  def set_pricing
    @pricing = Pricing.find(params[:id])
  end
end
