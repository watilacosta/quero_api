# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Student, type: :model do
  describe 'validations' do
    subject do
      Student.create!(
        name: 'Student 1',
        cpf: '060.567.500-78',
        birthdate: '10/08/2000',
        payment_method: [0, 1].sample
      )
    end

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:cpf) }
    it { is_expected.to validate_uniqueness_of(:cpf).case_insensitive }
    it 'is expected to be valid' do
      expect(subject).to be_valid
    end

    it 'is expect to not be valid' do
      expect(Student.new).to_not be_valid
    end

    it { is_expected.to allow_value(nil).for(:birthdate) }
    it 'is expected to be kind of Date' do
      expect(subject.birthdate).to be_kind_of(Date)
    end

    it { is_expected.to define_enum_for(:payment_method).with_values(%i[credit_card bankslip]) }
    it { is_expected.to validate_presence_of(:payment_method) }
    it 'is expected to be payment method not be blank', :aggregate_failures do
      expect(subject.payment_method).to_not be_nil
      expect(subject.payment_method).to_not be_empty
    end
  end
end
