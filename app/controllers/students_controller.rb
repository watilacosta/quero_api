# frozen_string_literal: true

class StudentsController < ApplicationController
  def index
    students = Student.page(params[:page]).per(params[:count])
    students_serialized = StudentSerializer.new(students).serializable_hash

    render json: { page: params[:page] || 1 }.merge(students_serialized), status: :ok
  end

  def create
    @student = Student.new(student_params)

    if @student.save
      render json: @student.id, status: :created
    else
      render json: @student.errors, status: :unprocessable_entity
    end
  end

  private

  def student_params
    params.require(:student).permit(:name, :cpf, :birthdate, :payment_method)
  end
end
