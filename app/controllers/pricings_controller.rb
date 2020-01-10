class PricingsController < ApplicationController  

  def price_dimension
    pricings = Pricing.with_dimensions
    pricings = pricings.where(region: params[:region]) if params[:region]
    pricings = pricings.where("DATE(effective_date) = ?", params[:date]) if params[:date]
    render json: pricings, status: :ok
  end

  def create
    pricing = Pricing.new(permit_params)
    if pricing.save
      render json: pricing.to_json, status: :created
    else
      render json: { errors: pricing.errors }, status: :unprocessable_entity
    end
  end

  private

  def permit_params
    params.require(:pricing).permit(:sku, :effective_date, :region, price_dimensions_attributes: [:description, :begin_range, :end_range, :unit, :price_per_unit])
  end
end
