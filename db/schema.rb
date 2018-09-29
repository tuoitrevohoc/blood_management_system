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

ActiveRecord::Schema.define(version: 20180929064136) do

  create_table "admin_histories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "place_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["place_id"], name: "index_admin_histories_on_place_id", using: :btree
    t.index ["user_id"], name: "index_admin_histories_on_user_id", using: :btree
  end

  create_table "articles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "content",    limit: 65535
    t.string   "title_slug"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.boolean  "is_public",                default: false
    t.string   "image"
    t.boolean  "is_pinned",                default: false
    t.integer  "views",                    default: 0
    t.string   "uid"
    t.index ["title_slug"], name: "index_articles_on_title_slug", using: :btree
    t.index ["user_id"], name: "index_articles_on_user_id", using: :btree
  end

  create_table "ckeditor_assets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["type"], name: "index_ckeditor_assets_on_type", using: :btree
  end

  create_table "departments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "place_id"
    t.string   "name"
    t.string   "head_doctor"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["place_id"], name: "index_departments_on_place_id", using: :btree
  end

  create_table "event_images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "image"
    t.string   "caption"
    t.integer  "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_images_on_event_id", using: :btree
  end

  create_table "events", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.datetime "date_time"
    t.text     "content",    limit: 65535
    t.integer  "place_id"
    t.integer  "user_id"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "image"
    t.boolean  "is_public",                default: false
    t.string   "title_slug"
    t.integer  "views",                    default: 0
    t.string   "uid"
    t.index ["place_id"], name: "index_events_on_place_id", using: :btree
    t.index ["title"], name: "index_events_on_title", using: :btree
    t.index ["user_id"], name: "index_events_on_user_id", using: :btree
  end

  create_table "histories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "place_id"
    t.date     "date"
    t.integer  "admin_id"
    t.boolean  "is_verified",    default: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "donation_type",  default: 0
    t.integer  "platelet_count"
    t.string   "referer"
    t.integer  "patient_id"
    t.datetime "deleted_at"
    t.index ["date"], name: "index_histories_on_date", using: :btree
    t.index ["deleted_at"], name: "index_histories_on_deleted_at", using: :btree
    t.index ["patient_id"], name: "index_histories_on_patient_id", using: :btree
    t.index ["place_id"], name: "index_histories_on_place_id", using: :btree
    t.index ["user_id", "place_id", "date"], name: "index_histories_on_user_id_and_place_id_and_date", unique: true, using: :btree
    t.index ["user_id"], name: "index_histories_on_user_id", using: :btree
  end

  create_table "patients", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.date     "birthday"
    t.integer  "gender"
    t.integer  "blood_type"
    t.string   "pathological"
    t.string   "room_number"
    t.string   "phone_number"
    t.string   "phone_number_2"
    t.string   "address"
    t.text     "history_of_pathology", limit: 65535
    t.string   "description"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "department_id"
    t.string   "place_of_birth"
    t.string   "id_number"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_patients_on_deleted_at", using: :btree
    t.index ["department_id"], name: "index_patients_on_department_id", using: :btree
  end

  create_table "places", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "address"
    t.float    "longitude",         limit: 24
    t.float    "latitude",          limit: 24
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "formatted_address"
    t.boolean  "is_hospital",                  default: true
    t.index ["address"], name: "index_places_on_address", using: :btree
    t.index ["name", "address"], name: "index_places_on_name_and_address", unique: true, using: :btree
    t.index ["name"], name: "index_places_on_name", using: :btree
  end

  create_table "posts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_posts_on_user_id", using: :btree
  end

  create_table "system_logs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "action_type"
    t.integer  "target_id"
    t.integer  "actor_id"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "target_type"
    t.index ["action_type"], name: "index_system_logs_on_action_type", using: :btree
    t.index ["target_id"], name: "index_system_logs_on_target_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email"
    t.string   "encrypted_password",                default: "",    null: false
    t.string   "name"
    t.string   "address"
    t.integer  "gender",                            default: 0
    t.string   "id_number"
    t.string   "phone_number"
    t.integer  "blood_type"
    t.boolean  "is_suscribed_email",                default: true
    t.integer  "role",                              default: 0
    t.string   "avatar"
    t.string   "uid"
    t.string   "provider"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.boolean  "is_public_profile",                 default: false
    t.boolean  "is_volunteer",                      default: true
    t.date     "birthday"
    t.float    "lat",                    limit: 24
    t.float    "lon",                    limit: 24
    t.string   "formatted_address"
    t.string   "phone_number_2"
    t.string   "facebook_account"
    t.string   "place_of_birth"
    t.string   "description"
    t.datetime "deleted_at"
    t.string   "reason_for_deleting"
    t.index ["address"], name: "index_users_on_address", using: :btree
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["deleted_at"], name: "index_users_on_deleted_at", using: :btree
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["lat", "lon"], name: "index_users_on_lat_and_lon", using: :btree
    t.index ["lat"], name: "index_users_on_lat", using: :btree
    t.index ["lon"], name: "index_users_on_lon", using: :btree
    t.index ["name", "address"], name: "index_users_on_name_and_address", using: :btree
    t.index ["name"], name: "index_users_on_name", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "admin_histories", "places"
  add_foreign_key "admin_histories", "users"
  add_foreign_key "articles", "users"
  add_foreign_key "departments", "places"
  add_foreign_key "event_images", "events"
  add_foreign_key "events", "places"
  add_foreign_key "histories", "places"
  add_foreign_key "histories", "users"
  add_foreign_key "patients", "departments"
  add_foreign_key "posts", "users"
end
