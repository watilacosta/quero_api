# frozen_string_literal: true

class Student < ApplicationRecord
  validates_with CpfValidator
  validates_with BirthdateValidator

  validates :name, presence: true
  validates :cpf, presence: true, uniqueness: true
  validates :payment_method, presence: true

  enum payment_method: { credit_card: 0, bankslip: 1 }
end
