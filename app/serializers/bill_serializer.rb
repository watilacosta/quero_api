# frozen_string_literal: true

class BillSerializer
  include JSONAPI::Serializer

  belongs_to :enrollment

  attributes :id, :amount, :due_date, :status
end
