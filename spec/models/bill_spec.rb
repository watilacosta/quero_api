# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bill, type: :model do
  before do
    Student.create!(
      name: 'Student 1',
      cpf: '060.567.500-78',
      birthdate: '10/08/2000',
      payment_method: [0, 1].sample
    )
    Enrollment.create!(
      amount: 20_000,
      installments: 5,
      due_day: 10,
      student_id: Student.last.id
    )
  end

  subject do
    Bill.create!(
      amount: 150_000,
      due_date: '22-07-2022',
      status: [0, 1, 2].sample,
      enrollment_id: Enrollment.last.id
    )
  end

  describe 'associations' do
    it { is_expected.to belong_to(:enrollment).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:amount) }
    it { is_expected.to validate_numericality_of(:amount).is_greater_than(0) }
    it { is_expected.to validate_presence_of(:due_date) }
    it { is_expected.to be_valid(:due_date) }
    it { is_expected.to define_enum_for(:status).with_values(%i[open pending paid]) }
    it { is_expected.to validate_presence_of(:status) }

    it 'is expected to status default is 0 (open)', :aggregate_failures do
      bill = Bill.create!(
        amount: 150_000,
        due_date: '22-07-2022',
        enrollment_id: Enrollment.last.id
      )

      expect(bill).to be_valid
      expect(bill.status).to eq('open')
      expect(bill.status).to_not eq('pending')
      expect(bill.status).to_not eq('paid')
    end
  end
end
