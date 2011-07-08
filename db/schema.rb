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

ActiveRecord::Schema.define(:version => 20110708102839) do

  create_table "artists", :force => true do |t|
    t.integer  "user_id",                                                   :null => false
    t.decimal  "balance",    :precision => 8, :scale => 2, :default => 0.0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "artists", ["user_id"], :name => "index_artists_on_user_id", :unique => true

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

  add_foreign_key "wallstickers", "artists", :name => "wallstickers_artist_id_fk", :dependent => :restrict

end
