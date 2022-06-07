# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Enrollments', type: :request do
  before do
    create_list(:enrollment, 10)
    get enrollments_path, params: { page: 1, count: 3 }
  end

  describe 'GET /enrollments' do
    context 'request with page and count params' do
      it 'returns a success response' do
        expect(response).to be_successful
      end

      it 'returns a list with 3 enrollments' do
        expect(json['data'].length).to eq(3)
      end
    end

    context 'request without params' do
      before do
        get enrollments_path
      end

      it 'returns a success response' do
        expect(response).to be_successful
      end

      it 'returns a list with 10 enrollments' do
        expect(json['data'].length).to eq(10)
      end
    end
  end

  describe 'POST /enrollments' do
    context 'with valid params' do
      before do
        student = create(:student)
        enrollment = attributes_for(:enrollment, student_id: student.id)

        post enrollments_path, params: { enrollment: }

        json['installments'].times do |index|
          Bill.create(
            enrollment_id: json['id'],
            amount: json['amount'] / json['installments'],
            due_date: if json['due_day'] < Date.today.day
                        Date.today.advance(months: index + 1)
                      elsif Date.today.day + json['due_day'] >= Date.today.end_of_month.day
                        Date.today.end_of_month
                      else
                        Date.today.advance(days: json['due_day'], months: index)
                      end
          )
        end
      end

      it 'returns http success' do
        expect(response).to have_http_status(:created)
      end
    end

    # context 'with invalid params' do
    #   before do
    #     post enrollments_path, params: { enrollment: attributes_for(:enrollment, :invalid) }
    #   end
    #
    #   it 'returns an error response' do
    #     expect(response).to have_http_status(:unprocessable_entity)
    #   end
    #
    #   it 'returns a list with 10 enrollments' do
    #     expect(json['data'].length).to eq(10)
    #   end
    # end
  end
end
