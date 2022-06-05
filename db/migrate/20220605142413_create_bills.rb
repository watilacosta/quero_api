# frozen_string_literal: true

class CreateBills < ActiveRecord::Migration[7.0] # :nodoc:
  def change
    create_table :bills do |t|
      t.integer :amount, null: false
      t.date :due_date, null: false
      t.integer :status, null: false, default: 0
      t.references :enrollment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
