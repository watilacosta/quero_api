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
        post enrollments_path, params: {
          enrollment: attributes_for(:enrollment, student_id: student.id)
        }
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
