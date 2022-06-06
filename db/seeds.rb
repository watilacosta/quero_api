# frozen_string_literal: true

puts 'Creating Faker Students'

100.times do
  FactoryBot.create(:student)
end

puts "Created #{Student.count} students"
