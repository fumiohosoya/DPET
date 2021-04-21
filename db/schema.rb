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

ActiveRecord::Schema.define(version: 2021_02_20_124922) do

  create_table "drivers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "sex"
    t.date "date_birth"
    t.integer "age"
    t.date "hire_date"
    t.string "blood_type"
    t.string "chronic_disease"
    t.string "accident_record"
    t.string "vioration_record"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "high_way_costs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.date "date"
    t.integer "total_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "vehicle_id"
  end

  create_table "highwayfees", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "vehicle_id"
    t.date "date"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "highways", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "vehicle_id"
    t.date "date"
    t.integer "total_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "insurances", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.integer "price"
    t.integer "vehicle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "other_costs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "vehicle_id"
    t.date "date"
    t.integer "total_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "others", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "vehicle_id"
    t.date "date"
    t.integer "total_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "special_costs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "vehicle_id"
    t.date "date"
    t.integer "total_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vehicle_sales", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "vehicle_id"
    t.date "date"
    t.integer "maintenance"
    t.integer "insurance"
    t.integer "highway"
    t.integer "others"
    t.float "fuel"
    t.float "mileage"
    t.float "fuel_consumption"
    t.integer "direct_labor_cost"
    t.integer "indirect_labor_cost"
    t.integer "special_cost"
    t.integer "other_cost"
    t.float "sales_month"
    t.float "profit_month"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "total_cost"
    t.float "fuel_cost"
    t.float "fuel_price"
  end

  create_table "vehicles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "model"
    t.string "type"
    t.integer "cost"
    t.integer "depreciation"
    t.integer "maintenance"
    t.integer "insurance"
    t.integer "highway"
    t.integer "others"
    t.integer "fuel"
    t.integer "mileage"
    t.integer "fuel_consumption"
    t.integer "direct_labor_cost"
    t.integer "indirect_labor_cost"
    t.integer "special_cost"
    t.integer "other_cost"
    t.integer "sales_month"
    t.integer "profit_month"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
