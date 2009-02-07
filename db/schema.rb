# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090116042821) do

  create_table "roles", :force => true do |t|
    t.string  "name"
    t.string  "description", :limit => 2000000000
    t.integer "created_at",  :limit => 2000000000
    t.integer "updated_at",  :limit => 2000000000
  end

  create_table "user_roles", :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.integer "created_at", :limit => 2000000000
    t.integer "updated_at", :limit => 2000000000
  end

  create_table "users", :force => true do |t|
    t.string  "email"
    t.string  "crypted_password",          :limit => 40
    t.string  "salt",                      :limit => 40
    t.string  "remember_token"
    t.integer "remember_token_expires_at", :limit => 2000000000
    t.integer "confirmed",                 :limit => 1
  end

  add_index "users", ["email", "crypted_password"], :name => "index_users_on_email_and_crypted_password"
  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["id", "salt"], :name => "index_users_on_id_and_salt"
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
