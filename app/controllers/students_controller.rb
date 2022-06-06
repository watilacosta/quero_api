# frozen_string_literal: true

class StudentsController < ApplicationController
  def index
    @students = Student.page(params[:page]).per(params[:count])
    student_serialized = StudentSerializer.new(@students).serializable_hash

    render json: { page: params[:page] || 1 }.merge(student_serialized), status: :ok
  end
end
