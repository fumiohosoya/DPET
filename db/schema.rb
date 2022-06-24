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

ActiveRecord::Schema.define(version: 2022_06_24_092617) do

  create_table "branches", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "company_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "checkimages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "image"
    t.bigint "checkitem_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["checkitem_id"], name: "index_checkimages_on_checkitem_id"
  end

  create_table "checkitems", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "type"
    t.bigint "driver_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "lamp"
    t.boolean "stopper"
    t.boolean "oilDrops"
    t.index ["driver_id"], name: "index_checkitems_on_driver_id"
  end

  create_table "checkmenus", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "company_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "checkschedules", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "dayofweek"
    t.bigint "checkmenu_id"
    t.integer "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["checkmenu_id"], name: "index_checkschedules_on_checkmenu_id"
  end

  create_table "companies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name_j"
    t.string "name_e"
    t.boolean "opt_tirerotation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

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
    t.string "company"
    t.string "branch"
    t.string "email"
    t.string "password_digest"
  end

  create_table "evaluates", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "type"
    t.bigint "driver_id"
    t.integer "op_count"
    t.integer "empty_conv"
    t.integer "occupied_conv"
    t.integer "mileage"
    t.datetime "handling"
    t.integer "speedover"
    t.datetime "spover_time"
    t.integer "scramble"
    t.integer "rapid_accel"
    t.integer "abrupt_decel"
    t.datetime "idling"
    t.datetime "running"
    t.float "evaluate"
    t.string "rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "recordmonth"
    t.index ["driver_id"], name: "index_evaluates_on_driver_id"
  end

  create_table "ext_check_menus", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.date "record_date"
    t.string "type"
    t.string "name"
    t.integer "company_id"
    t.string "description"
    t.string "image_url"
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

  create_table "truckrelations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "truck_id"
    t.bigint "driver_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["driver_id"], name: "index_truckrelations_on_driver_id"
    t.index ["truck_id"], name: "index_truckrelations_on_truck_id"
  end

  create_table "trucks", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "company_id"
    t.integer "branch_id"
    t.string "maker"
    t.string "model"
    t.string "body"
    t.integer "wheels"
    t.string "year"
    t.string "age"
    t.string "engine"
    t.string "vehicleid"
    t.string "number"
    t.integer "e_oil"
    t.integer "tm_oil"
    t.string "tire"
    t.integer "df_oil"
    t.string "initmileage"
    t.string "purchase"
    t.string "image_url"
    t.string "thumb_url"
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

  add_foreign_key "checkimages", "checkitems"
  add_foreign_key "checkitems", "drivers"
  add_foreign_key "checkschedules", "checkmenus"
  add_foreign_key "evaluates", "drivers"
  add_foreign_key "truckrelations", "drivers"
  add_foreign_key "truckrelations", "trucks"
end
