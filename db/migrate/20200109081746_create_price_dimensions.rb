class CreatePriceDimensions < ActiveRecord::Migration[5.2]
  def change
    create_table :price_dimensions do |t|
      t.text :description
      t.integer :begin_range
      t.integer :end_range
      t.string :unit
      t.decimal :price_per_unit, precision: 15, scale: 10
      t.references :pricing

      t.timestamps
    end
  end
end
