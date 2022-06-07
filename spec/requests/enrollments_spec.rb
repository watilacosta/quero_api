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
    let(:authorization) { ActionController::HttpAuthentication::Basic.encode_credentials('admin_ops', 'billing') }
    let(:headers) { { 'HTTP_AUTHORIZATION' => authorization } }

    context 'with valid params' do
      before do
        student = create(:student)
        enrollment = attributes_for(:enrollment, student_id: student.id)

        post enrollments_path, params: { enrollment: }, headers: headers

        if json['data'].present?
          json_response = json['data']['attributes']
          json_response['installments'].times do |index|
            Bill.create(
              enrollment_id: json_response['id'],
              amount: json_response['amount'] / json_response['installments'],
              due_date: if json_response['due_day'] < Date.today.day
                          Date.new(Date.today.year, Date.today.month, json_response['due_day'])
                              .advance(months: index + 1)
                        else
                          due_date = Date.new(Date.today.year, Date.today.month, json_response['due_day'])
                          due_date + index.months
                        end
            )
          end
        end
      end

      it 'returns http success' do
        expect(response).to have_http_status(:created)
      end

      it 'returns the correct number of bills' do
        expect(json['data']['attributes']['installments']).to eq(Enrollment.last.installments)
      end

      it 'returns the correct attributes', :aggregate_failures do
        expect(json['data']['attributes']['amount']).to eq(Enrollment.last.amount)
        expect(json['data']['attributes']['due_day']).to eq(Enrollment.last.due_day)
        expect(json['data']['attributes']['student_id']).to eq(Enrollment.last.student_id)
      end
    end

    context 'with invalid params' do
      before do
        post enrollments_path, params: { enrollment: { installments: nil } }, headers: headers
      end

      it 'returns http unprocessable entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns the correct error message' do
        expect(json['errors']['installments']).to eq(["can't be blank", 'is not a number'])
      end
    end
  end
end
