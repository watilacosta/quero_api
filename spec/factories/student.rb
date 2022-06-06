# frozen_string_literal: true

FactoryBot.define do
  factory :student do
    name           { Faker::Name.name }
    cpf            { Faker::CPF.pretty }
    birthdate      { '01/01/2000' }
    payment_method { [0, 1].sample }
  end
end
