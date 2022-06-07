# frozen_string_literal: true

class StudentSerializer
  include JSONAPI::Serializer

  has_many :enrollments

  attributes :id, :name, :cpf, :birthdate, :payment_method
end
