# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20121203214605) do

  create_table "request_signatures", :force => true do |t|
    t.string   "accept"
    t.string   "accept_charset"
    t.string   "accept_encoding"
    t.string   "accept_language"
    t.string   "checksum",        :limit => 128, :null => false
    t.string   "remote_ip",       :limit => 15,  :null => false
    t.integer  "user_agent_id",                  :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "request_signatures", ["accept", "accept_charset", "accept_encoding", "accept_language", "remote_ip"], :name => "index_accept_checksum"
  add_index "request_signatures", ["checksum"], :name => "index_request_signatures_on_checksum", :unique => true
  add_index "request_signatures", ["user_agent_id"], :name => "index_request_signatures_on_user_agent_id", :unique => true

  create_table "resource_requests", :force => true do |t|
    t.integer  "request_signature_id", :null => false
    t.integer  "resource_id",          :null => false
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  add_index "resource_requests", ["request_signature_id"], :name => "index_resource_requests_on_request_signature_id"
  add_index "resource_requests", ["resource_id"], :name => "index_resource_requests_on_resource_id"

  create_table "resources", :force => true do |t|
    t.string "path"
  end

  add_index "resources", ["path"], :name => "index_resources_on_path", :unique => true

  create_table "user_agents", :force => true do |t|
    t.string   "agent"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_agents", ["agent"], :name => "index_user_agents_on_agent", :unique => true

end
