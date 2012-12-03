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

ActiveRecord::Schema.define(:version => 20121202143103) do

  create_table "request_signatures", :force => true do |t|
    t.string   "accept"
    t.string   "accept_charset"
    t.string   "accept_encoding"
    t.string   "accept_language"
    t.string   "remote_ip"
    t.integer  "resource_request_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "request_signatures", ["accept"], :name => "index_request_signatures_on_accept"
  add_index "request_signatures", ["accept_charset"], :name => "index_request_signatures_on_accept_charset"
  add_index "request_signatures", ["accept_encoding"], :name => "index_request_signatures_on_accept_encoding"
  add_index "request_signatures", ["accept_language"], :name => "index_request_signatures_on_accept_language"
  add_index "request_signatures", ["remote_ip"], :name => "index_request_signatures_on_remote_ip"
  add_index "request_signatures", ["resource_request_id"], :name => "index_request_signatures_on_resource_request_id", :unique => true

  create_table "resource_requests", :force => true do |t|
    t.string   "http_referer"
    t.string   "remote_ip"
    t.string   "request_uuid"
    t.integer  "resource_id"
    t.integer  "user_id"
    t.integer  "user_agent_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "resource_requests", ["http_referer"], :name => "index_resource_requests_on_http_referer"
  add_index "resource_requests", ["request_uuid"], :name => "index_resource_requests_on_request_uuid", :unique => true
  add_index "resource_requests", ["resource_id"], :name => "index_resource_requests_on_resource_id"
  add_index "resource_requests", ["user_agent_id"], :name => "index_resource_requests_on_user_agent_id"
  add_index "resource_requests", ["user_id"], :name => "index_resource_requests_on_user_id"

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

  create_table "users", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
