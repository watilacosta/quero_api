# frozen_string_literal: true

class EnrollmentSerializer
  include JSONAPI::Serializer

  attributes :id, :student_id, :amount, :installments, :due_day, :bills
end
