# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_01_09_081746) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "price_dimensions", force: :cascade do |t|
    t.text "description"
    t.integer "begin_range"
    t.integer "end_range"
    t.string "unit"
    t.decimal "price_per_unit", precision: 15, scale: 10
    t.bigint "pricing_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pricing_id"], name: "index_price_dimensions_on_pricing_id"
  end

  create_table "pricings", force: :cascade do |t|
    t.string "sku"
    t.string "region"
    t.datetime "effective_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
