# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Students', type: :request do
  before do
    create_list(:student, 10)
    get students_path, params: { page: 1, count: 3 }
  end

  describe 'GET /index' do
    context 'with page and count params' do
      it 'returns http success' do
        expect(response).to have_http_status(:ok)
      end
      it 'returns json' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
      it 'returns 5 students' do
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
end
