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

  def self.generate_due_date(due_day, index)
    if due_day < Date.today.day
      Date.new(Date.today.year, Date.today.month, due_day).advance(months: index + 1)
    else
      due_date = Date.new(Date.today.year, Date.today.month, due_day)
      due_date + index.months
    end
  end
end
