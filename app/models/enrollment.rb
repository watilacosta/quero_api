# frozen_string_literal: true

class Enrollment < ApplicationRecord
  belongs_to :student, dependent: :destroy
  has_many :bills

  validates :amount, presence: true
  validates :amount, numericality: { greater_than: 0 }
  validates :installments, presence: true
  validates :installments, numericality: { greater_than: 1 }
  validates :due_day, presence: true
  validates_numericality_of :due_day, greater_than_or_equal_to: 1, less_than_or_equal_to: 31

  def self.serializing_enrollment(params)
    enrollments = Enrollment.page(params[:page]).per(params[:count])
    EnrollmentSerializer.new(enrollments).serializable_hash
  end
end
