class Pricing < ApplicationRecord
  has_many :price_dimensions, dependent: :destroy
  validates :region, :effective_date, presence: true
  validates :sku, uniqueness: { scope: [:region, :effective_date], message: 'should have unique effective_date and region' }, presence: true

  accepts_nested_attributes_for :price_dimensions, reject_if: :all_blank

  scope :with_dimensions, -> { 
    joins(:price_dimensions).select('pricings.id as id, pricings.effective_date, price_dimensions.description, price_dimensions.begin_range, price_dimensions.end_range, price_dimensions.unit, price_dimensions.price_per_unit') 
  }

  def to_json
    attributes
  end

  def as_json(options = {})    
  	{      
  		description: description,
  		beginRange: begin_range,
  		endRange: end_range,
  		unit: unit,
  		pricePerUnit: price_per_unit,
  		effectiveDate: effective_date
  	}
  end
end
