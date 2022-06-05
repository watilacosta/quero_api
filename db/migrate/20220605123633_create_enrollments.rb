# frozen_string_literal: true

class CreateEnrollments < ActiveRecord::Migration[7.0] # :nodoc:
  def change
    create_table :enrollments do |t|
      t.integer :amount, null: false
      t.integer :installments, null: false
      t.integer :due_day, null: false
      t.references :student, null: false, foreign_key: true

      t.timestamps
    end
  end
end
