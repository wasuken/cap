# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_27_201335) do

  create_table "dsts", force: :cascade do |t|
    t.integer "dport", null: false
    t.string "dip", null: false
    t.string "dmac", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "hosts", force: :cascade do |t|
    t.string "name", null: false
    t.string "htoken", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["htoken"], name: "index_hosts_on_htoken", unique: true
  end

  create_table "letsencrypt_certificates", force: :cascade do |t|
    t.string "domain"
    t.text "certificate", limit: 65535
    t.text "intermediaries", limit: 65535
    t.text "key", limit: 65535
    t.datetime "expires_at"
    t.datetime "renew_after"
    t.string "verification_path"
    t.string "verification_string"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["domain"], name: "index_letsencrypt_certificates_on_domain"
    t.index ["renew_after"], name: "index_letsencrypt_certificates_on_renew_after"
  end

  create_table "net_packets", force: :cascade do |t|
    t.integer "dst_id", null: false
    t.integer "src_id", null: false
    t.integer "host_id", null: false
    t.string "packet_type", default: "tcp"
    t.string "iface_name", null: false
    t.string "content", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "srcs", force: :cascade do |t|
    t.integer "sport", null: false
    t.string "sip", null: false
    t.string "smac", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "token", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["token"], name: "index_users_on_token", unique: true
  end

end
