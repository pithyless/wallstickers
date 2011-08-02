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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110802153112) do

  create_table "artists", :force => true do |t|
    t.integer  "user_id",                                                   :null => false
    t.decimal  "balance",    :precision => 8, :scale => 2, :default => 0.0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "artists", ["user_id"], :name => "index_artists_on_user_id", :unique => true

  create_table "order_items", :force => true do |t|
    t.integer  "user_id"
    t.integer  "order_id"
    t.integer  "wallsticker_variant_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", :force => true do |t|
    t.integer  "user_id",                                   :null => false
    t.string   "state",                                     :null => false
    t.time     "paid_at"
    t.time     "printed_at"
    t.time     "shipped_at"
    t.decimal  "balance_pln", :precision => 8, :scale => 2, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token",                                     :null => false
  end

  add_index "orders", ["token"], :name => "index_orders_on_token", :unique => true
  add_index "orders", ["user_id"], :name => "index_orders_on_user_id"

  create_table "printers", :force => true do |t|
    t.integer  "user_id",      :null => false
    t.integer  "publisher_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "printers", ["user_id"], :name => "index_printers_on_user_id", :unique => true

  create_table "publishers", :force => true do |t|
    t.string   "slug",       :null => false
    t.string   "name",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "publishers", ["slug"], :name => "index_publishers_on_slug", :unique => true

  create_table "users", :force => true do |t|
    t.string   "username",         :null => false
    t.string   "email",            :null => false
    t.string   "first_name",       :null => false
    t.string   "last_name",        :null => false
    t.string   "crypted_password", :null => false
    t.string   "salt",             :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

  create_table "wallsticker_variants", :force => true do |t|
    t.integer  "wallsticker_id",                               :null => false
    t.string   "color",                                        :null => false
    t.integer  "width_cm",                                     :null => false
    t.integer  "height_cm",                                    :null => false
    t.decimal  "price_pln",      :precision => 8, :scale => 2, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wallsticker_variants", ["wallsticker_id"], :name => "index_wallsticker_variants_on_wallsticker_id"

  create_table "wallstickers", :force => true do |t|
    t.integer  "artist_id",    :null => false
    t.string   "title",        :null => false
    t.string   "permalink",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "source_image", :null => false
  end

  add_index "wallstickers", ["artist_id"], :name => "index_wallstickers_on_artist_id"
  add_index "wallstickers", ["permalink"], :name => "index_wallstickers_on_permalink", :unique => true

  add_foreign_key "artists", "users", :name => "talents_user_id_fk", :dependent => :restrict

  add_foreign_key "order_items", "orders", :name => "order_items_order_id_fk", :dependent => :restrict
  add_foreign_key "order_items", "users", :name => "order_items_user_id_fk", :dependent => :restrict

  add_foreign_key "orders", "users", :name => "orders_user_id_fk", :dependent => :restrict

  add_foreign_key "printers", "publishers", :name => "printers_publisher_id_fk", :dependent => :restrict
  add_foreign_key "printers", "users", :name => "printers_user_id_fk", :dependent => :restrict

  add_foreign_key "wallsticker_variants", "wallstickers", :name => "wallsticker_variants_wallsticker_id_fk", :dependent => :restrict

  add_foreign_key "wallstickers", "artists", :name => "wallstickers_artist_id_fk", :dependent => :restrict

end
