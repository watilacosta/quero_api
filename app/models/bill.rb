# frozen_string_literal: true

class Bill < ApplicationRecord
  belongs_to :enrollment, dependent: :destroy

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :due_date, presence: true
  validates :status, presence: true

  validates_with DueDateValidator

  enum status: {
    open: 0,
    pending: 1,
    paid: 2
  }
end
