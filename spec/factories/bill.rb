# frozen_string_literal: true

FactoryBot.define do
  factory :bill do
    amount   { Faker::Number.between(from: 100_000, to: 500_000) }
    due_date { Date.today + 1.month }
    status   { 'open' } # 0: open, 1: pending, 2: paid
    enrollment
  end
end
