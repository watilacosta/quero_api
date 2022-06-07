# frozen_string_literal: true

class StudentSerializer
  include JSONAPI::Serializer

  attributes :id, :name, :cpf, :birthdate, :payment_method
end
