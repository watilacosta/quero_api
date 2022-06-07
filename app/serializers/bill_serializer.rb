# frozen_string_literal: true

class BillSerializer
  include JSONAPI::Serializer

  belongs_to :enrollment, dependent: :destroy

  attributes :id, :due_date, :status, :amount
end
