# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Students', type: :request do
  before do
    create_list(:student, 10)
    get students_path, params: { page: 1, count: 3 }
  end

  describe 'GET /students' do
    context 'with page and count params' do
      it 'returns http success' do
        expect(response).to have_http_status(:ok)
      end
      it 'returns json' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
      it 'returns a list with 3 students' do
        expect(json['data'].length).to eq(3)
      end
    end

    context 'without params' do
      before { get students_path }

      it 'returns http success' do
        expect(response).to have_http_status(:ok)
      end
      it 'returns json' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
      it 'returns 10 students' do
        expect(json['data'].length).to eq(10)
      end
    end
  end

  describe 'POST /students' do
    context 'with valid params' do
      before do
        params = attributes_for(:student)
        post students_path, params: { student: params }
      end

      it 'returns http success' do
        expect(response).to have_http_status(:created)
      end

      it 'returns student id' do
        expect(json).to eq(Student.last.id)
      end
    end

    context 'with invalid params' do
      before do
        params = attributes_for(:student, cpf: nil)
        post students_path, params: { student: params }
      end

      it 'returns http unprocessable entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns error message' do
        expect(json['cpf']).to eq(['inválido!', "can't be blank"])
      end
    end
  end
end

