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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150124090404) do

  create_table "Nodes", force: :cascade do |t|
    t.integer  "model_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "point_name"
    t.string   "floor_name"
    t.float    "X"
    t.float    "Y"
    t.float    "Z"
  end

  create_table "Profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "company"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "active_name"
  end

  create_table "analyses", force: :cascade do |t|
    t.integer  "model_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "analysis_options", force: :cascade do |t|
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.boolean  "panel_zone_rigidity"
    t.integer  "mtp"
    t.integer  "nss"
    t.float    "beta"
    t.float    "gamma"
    t.float    "a0"
    t.float    "first_mode_period"
    t.float    "damping_ratio_stiffness"
    t.float    "damping_ratio_column"
    t.float    "base_shear_percent"
    t.float    "base_shear"
    t.float    "r"
    t.float    "base_drift"
    t.float    "dt"
    t.float    "irint"
    t.boolean  "irout"
    t.float    "istop"
    t.integer  "debuglevel"
    t.boolean  "sectionconversion"
    t.boolean  "matconversion"
    t.integer  "default_id"
    t.float    "ndim"
  end

  create_table "convergence_options", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "mig"
    t.float    "tol1"
    t.float    "tol3"
    t.float    "tol5"
    t.float    "tol7"
    t.float    "alphac"
    t.float    "a3"
    t.integer  "default_id"
  end

  create_table "defaults", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "config_id"
    t.string   "name"
    t.string   "config_type"
  end

  create_table "extra_time_histories", force: :cascade do |t|
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "response_time_history_option_id"
    t.float    "x1"
    t.float    "y1"
    t.float    "z1"
    t.float    "x2"
    t.float    "y2"
    t.float    "z2"
    t.integer  "outputtype"
    t.integer  "outputvalue"
    t.integer  "node_id"
    t.integer  "node2_id"
  end

  create_table "fiber_options", force: :cascade do |t|
    t.float    "eec"
    t.integer  "nsefbc"
    t.integer  "nsefbr"
    t.integer  "milf"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "default_id"
  end

  create_table "floors", force: :cascade do |t|
    t.integer  "model_id"
    t.string   "name"
    t.float    "elevation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "foundation_node_options", force: :cascade do |t|
    t.integer  "default_id"
    t.float    "ALP"
    t.float    "STRH"
    t.float    "STRVU"
    t.float    "STRVD"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "foundation_nodes", force: :cascade do |t|
    t.integer  "foundation_node_option_id"
    t.string   "name"
    t.float    "ALP"
    t.float    "STRH"
    t.float    "STRVU"
    t.float    "STRVD"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "load_combos", force: :cascade do |t|
    t.integer  "model_id"
    t.string   "case_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "load_options", force: :cascade do |t|
    t.string   "load_combo"
    t.string   "mass_combo"
    t.float    "gamult"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "default_id"
  end

  create_table "material_models", force: :cascade do |t|
    t.float    "defwallshearmod"
    t.string   "materialconv1"
    t.string   "materialconv2"
    t.string   "materialconv3"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.float    "steelmat_G"
    t.float    "steelmat_Sy"
    t.float    "mat_1_E"
    t.float    "mat_1_ES"
    t.float    "mat_1_SIGY"
    t.float    "mat_1_EPSS"
    t.float    "mat_1_EPSU"
    t.float    "mat_1_PRAT"
    t.float    "mat_1_RES"
    t.float    "mat_2_E"
    t.float    "mat_2_ES"
    t.float    "mat_2_SIGY"
    t.float    "mat_2_EPSS"
    t.float    "mat_2_EPSU"
    t.float    "mat_2_PRAT"
    t.float    "mat_2_RES"
    t.float    "concretemat_E"
    t.float    "concretemat_CS"
    t.float    "concretemat_PCT"
    t.integer  "default_id"
    t.float    "mat_1_SIGU"
    t.float    "mat_2_SIGU"
  end

  create_table "model_informations", force: :cascade do |t|
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "title"
    t.string   "primaryetabsdir"
    t.string   "steelsection"
    t.integer  "default_id"
  end

  create_table "models", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "e2k_file"
    t.integer  "user_id"
  end

  create_table "nsefbc_fibers", force: :cascade do |t|
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "number"
    t.float    "length"
    t.integer  "fiber_option_id"
  end

  create_table "nsefbr_fibers", force: :cascade do |t|
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "number"
    t.float    "length"
    t.integer  "fiber_option_id"
  end

  create_table "points", force: :cascade do |t|
    t.integer  "model_id"
    t.string   "name"
    t.float    "X"
    t.float    "Y"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "response_time_history_options", force: :cascade do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.boolean  "plotall"
    t.boolean  "plotsecondary"
    t.integer  "default_id"
  end

  create_table "resposne_time_history_options", force: :cascade do |t|
    t.integer  "user_id"
    t.boolean  "plotall"
    t.boolean  "plotsecondary"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "pasword"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "hashed_password"
  end

  create_table "vertical_constraint_options", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float    "alphavcdef"
    t.integer  "default_id"
  end

  create_table "vertical_constraints", force: :cascade do |t|
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "vertical_constraint_option_id"
    t.float    "x"
    t.float    "y"
    t.float    "z"
    t.float    "alphavc"
    t.integer  "node_id"
  end

end
