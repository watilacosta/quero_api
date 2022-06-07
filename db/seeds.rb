# frozen_string_literal: true

puts 'Creating Faker Students'

100.times do
  FactoryBot.create(:student)
end

puts "Created #{Student.count} students"

Student.first(10).each do |student|
  puts "Creating #{student.name} enrollment"
  enrollment = FactoryBot.create(:enrollment, student: student)

  enrollment[:installments].times do |index|
    puts "Creating #{student.name}'s installment's bills"

    bill = Bill.create!(
      enrollment_id: enrollment[:id],
      amount: enrollment[:amount] / enrollment[:installments],
      due_date: if enrollment[:due_day] < Date.today.day
                  Date.new(Date.today.year, Date.today.month, enrollment[:due_day])
                      .advance(months: index + 1)
                else
                  Date.new(Date.today.year, Date.today.month,
                           Bill.due_day_validated(enrollment[:due_day])) + index.months
                end
    )

    puts "Created bill id = #{bill.inspect}"
  end
end
