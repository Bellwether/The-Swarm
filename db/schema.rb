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

ActiveRecord::Schema.define(:version => 20120102171952) do

  create_table "accounts", :force => true do |t|
    t.string  "name",                              :null => false
    t.integer "campaign_limit",  :default => 1,    :null => false
    t.integer "campaigns_count", :default => 0,    :null => false
    t.integer "users_count",     :default => 0,    :null => false
    t.integer "contact_limit",   :default => 50,   :null => false
    t.integer "user_limit",      :default => 3,    :null => false
    t.boolean "active",          :default => true, :null => false
  end

  add_index "accounts", ["active"], :name => "index_accounts_on_active"

  create_table "campaigns", :force => true do |t|
    t.integer  "account_id",                    :null => false
    t.integer  "messages_count", :default => 0, :null => false
    t.string   "name",                          :null => false
    t.string   "topic_arn"
    t.datetime "created_at"
  end

  add_index "campaigns", ["account_id", "created_at"], :name => "index_campaigns_on_account_id_and_created_at"
  add_index "campaigns", ["topic_arn"], :name => "index_campaigns_on_topic_arn"

  create_table "contacts", :force => true do |t|
    t.integer  "account_id", :null => false
    t.string   "name",       :null => false
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at"
  end

  add_index "contacts", ["account_id", "created_at"], :name => "index_contacts_on_account_id_and_created_at"

  create_table "messages", :force => true do |t|
    t.integer  "user_id",     :null => false
    t.integer  "campaign_id", :null => false
    t.string   "subject",     :null => false
    t.text     "body"
    t.datetime "created_at"
  end

  create_table "subscriptions", :force => true do |t|
    t.integer  "campaign_id",      :null => false
    t.integer  "contact_id",       :null => false
    t.string   "endpoint",         :null => false
    t.string   "protocol",         :null => false
    t.string   "subscription_arn"
    t.datetime "created_at"
  end

  add_index "subscriptions", ["campaign_id"], :name => "index_subscriptions_on_campaign_id"
  add_index "subscriptions", ["contact_id"], :name => "index_subscriptions_on_contact_id"
  add_index "subscriptions", ["protocol"], :name => "index_subscriptions_on_protocol"

  create_table "users", :force => true do |t|
    t.integer "account_id",                        :null => false
    t.string  "name",                              :null => false
    t.string  "email",                             :null => false
    t.string  "password_digest",                   :null => false
    t.boolean "active",          :default => true, :null => false
  end

  add_index "users", ["account_id"], :name => "index_users_on_account_id"
  add_index "users", ["active", "email"], :name => "index_users_on_active_and_email"

end
