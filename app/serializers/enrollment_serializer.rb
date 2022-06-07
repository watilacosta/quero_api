# frozen_string_literal: true

class EnrollmentSerializer
  include JSONAPI::Serializer

  has_many :bills, serializer: BillSerializer

  attributes :id, :student_id, :amount, :installments, :due_day
end
