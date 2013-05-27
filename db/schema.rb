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

ActiveRecord::Schema.define(:version => 20130526222647) do

  create_table "authors", :force => true do |t|
    t.string   "name",       :default => "", :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "comments", :force => true do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "comments", ["commentable_id", "commentable_type"], :name => "index_comments_on_commentable_id_and_commentable_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "likes", :force => true do |t|
    t.integer  "likable_id",   :null => false
    t.string   "likable_type", :null => false
    t.integer  "user_id",      :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "likes", ["likable_id", "likable_type"], :name => "index_likes_on_likable_id_and_likable_type"
  add_index "likes", ["user_id"], :name => "index_likes_on_user_id"

  create_table "oauth_access_grants", :force => true do |t|
    t.integer  "resource_owner_id", :null => false
    t.integer  "application_id",    :null => false
    t.string   "token",             :null => false
    t.integer  "expires_in",        :null => false
    t.string   "redirect_uri",      :null => false
    t.datetime "created_at",        :null => false
    t.datetime "revoked_at"
    t.string   "scopes"
  end

  add_index "oauth_access_grants", ["token"], :name => "index_oauth_access_grants_on_token", :unique => true

  create_table "oauth_access_tokens", :force => true do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id",    :null => false
    t.string   "token",             :null => false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",        :null => false
    t.string   "scopes"
  end

  add_index "oauth_access_tokens", ["refresh_token"], :name => "index_oauth_access_tokens_on_refresh_token", :unique => true
  add_index "oauth_access_tokens", ["resource_owner_id"], :name => "index_oauth_access_tokens_on_resource_owner_id"
  add_index "oauth_access_tokens", ["token"], :name => "index_oauth_access_tokens_on_token", :unique => true

  create_table "oauth_applications", :force => true do |t|
    t.string   "name",         :null => false
    t.string   "uid",          :null => false
    t.string   "secret",       :null => false
    t.string   "redirect_uri", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "oauth_applications", ["uid"], :name => "index_oauth_applications_on_uid", :unique => true

  create_table "posts", :force => true do |t|
    t.text     "quote",                               :null => false
    t.text     "caption",                             :null => false
    t.string   "quote_image_uid"
    t.string   "quote_image_name"
    t.boolean  "editors_pick",     :default => false, :null => false
    t.integer  "likes_count",      :default => 0,     :null => false
    t.integer  "user_id"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.string   "author_name",      :default => ""
  end

  add_index "posts", ["editors_pick"], :name => "index_posts_on_editors_pick"
  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "quotes", :force => true do |t|
    t.text     "body",       :null => false
    t.integer  "author_id"
    t.text     "tags"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.text     "source"
  end

  add_index "quotes", ["author_id"], :name => "index_quotes_on_author_id"

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id",                         :null => false
    t.integer  "user_id",                             :null => false
    t.string   "status",      :default => "approved", :null => false
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

  add_index "relationships", ["follower_id", "user_id"], :name => "index_relationships_on_follower_id_and_user_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"
  add_index "relationships", ["user_id"], :name => "index_relationships_on_user_id"

  create_table "taggings", :force => true do |t|
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "user_id"
    t.integer  "tag_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type"], :name => "index_taggings_on_taggable_id_and_taggable_type"
  add_index "taggings", ["user_id"], :name => "index_taggings_on_user_id"

  create_table "tags", :force => true do |t|
    t.string   "name",        :default => "", :null => false
    t.integer  "posts_count", :default => 0,  :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",   :null => false
    t.string   "encrypted_password",     :default => "",   :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.string   "full_name"
    t.string   "profile_picture_uid"
    t.string   "profile_picture_name"
    t.boolean  "auto_accept",            :default => true
    t.integer  "facebook_id"
    t.text     "bio",                                      :null => false
    t.string   "website",                :default => "",   :null => false
    t.integer  "follows_count",          :default => 0
    t.integer  "followed_by_count",      :default => 0
    t.integer  "posts_count",            :default => 0
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
