# frozen_string_literal: true

FactoryBot.define do
  factory :student do
    name           { 'John' }
    cpf            { '419.092.310-96' }
    birthdate      { '01/01/2000' }
    payment_method { [0, 1].sample }
  end
end
