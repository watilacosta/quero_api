# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bill, type: :model do
  subject { create(:bill) }

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
      expect(subject).to be_valid
      expect(subject.status).to eq('open')
      expect(subject.status).to_not eq('pending')
      expect(subject.status).to_not eq('paid')
    end
  end
end
