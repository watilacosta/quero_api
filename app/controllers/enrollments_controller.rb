# frozen_string_literal: true

class EnrollmentsController < ApplicationController
  def index
    enrollments = serialize_enrollment(params)

    render json: { page: params[:page] || 1 }.merge(enrollments), status: :ok
  end

  def create
    enrollment = Enrollment.new(enrollment_params)

    if enrollment.save
      render json: enrollment, status: :created
    else
      render json: { errors: enrollment.errors }, status: :unprocessable_entity
    end
  end

  private

  def serialize_enrollment(params)
    enrollments = Enrollment.page(params[:page]).per(params[:count])
    EnrollmentSerializer.new(enrollments).serializable_hash
  end

  def enrollment_params
    params.require(:enrollment).permit(:amount, :installments, :due_day, :student_id)
  end
end
