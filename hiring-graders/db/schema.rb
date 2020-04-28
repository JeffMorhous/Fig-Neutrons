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

ActiveRecord::Schema.define(version: 2020_04_28_193015) do

  create_table "admins", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "availabilities", force: :cascade do |t|
    t.string "hour"
    t.integer "student_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "day"
    t.index ["student_id"], name: "index_availabilities_on_student_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "department", null: false
    t.string "section_number", null: false
    t.boolean "is_lab", null: false
    t.string "days"
    t.string "start_time"
    t.string "end_time"
    t.string "location"
    t.boolean "need_grader", default: true
    t.boolean "have_grader", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "instructor"
    t.string "course_number"
    t.string "semester"
  end

  create_table "evaluations", force: :cascade do |t|
    t.integer "course_id", null: false
    t.integer "student_id", null: false
    t.integer "instructor_id", null: false
    t.integer "quality"
    t.integer "punctuality"
    t.integer "com_skills"
    t.integer "course_knowledge"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_evaluations_on_course_id"
    t.index ["instructor_id"], name: "index_evaluations_on_instructor_id"
    t.index ["student_id"], name: "index_evaluations_on_student_id"
  end

  create_table "graders", force: :cascade do |t|
    t.string "semester"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "student_id"
    t.integer "course_id"
    t.index ["course_id"], name: "index_course_id"
    t.index ["student_id"], name: "index_student_id"
  end

  create_table "instructors", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "interesteds", force: :cascade do |t|
    t.string "department", null: false
    t.string "course", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "student_id"
    t.index ["student_id"], name: "index_interested_student_id"
  end

  create_table "recommendations", force: :cascade do |t|
    t.string "recommendation"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "student_email"
    t.integer "instructor_id"
    t.string "course_number"
    t.string "first_name"
    t.string "last_name"
    t.boolean "request"
    t.index ["instructor_id"], name: "index_recommendations_instructor_id"
  end

  create_table "semesters", force: :cascade do |t|
    t.string "semester"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "students", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.string "phone", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "has_graded_before", null: false
  end

  create_table "transcripts", force: :cascade do |t|
    t.integer "grade", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "student_id"
    t.integer "course_id"
    t.index ["course_id"], name: "index_transcript_course_id"
    t.index ["student_id"], name: "index_transcript_student_id"
  end

  add_foreign_key "availabilities", "students"
  add_foreign_key "evaluations", "courses"
  add_foreign_key "evaluations", "instructors"
  add_foreign_key "evaluations", "students"
end
