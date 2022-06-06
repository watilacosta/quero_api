# frozen_string_literal: true

FactoryBot.define do
  factory :enrollment do
    amount       { rand(10_000..500_000) }
    installments { rand(2..12) }
    due_day      { rand(1..31) }
    student
  end
end
