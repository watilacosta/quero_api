# frozen_string_literal: true

class EnrollmentsController < ApplicationController
  def index
    enrollments = Enrollment.serializing_enrollment(params)

    render json: { page: params[:page] || 1 }.merge(enrollments), status: :ok
  end

  def create
    enrollment = Enrollment.new(enrollment_params)

    if enrollment.save
      generate_bills(enrollment)
      enrollment_serialized = EnrollmentSerializer.new(enrollment).serializable_hash
      render json: enrollment_serialized, status: :created
    else
      render json: { errors: enrollment.errors }, status: :unprocessable_entity
    end
  end

  private

  def generate_bills(enrollment)
    enrollment.installments.times do |index|
      Bill.create!(
        enrollment_id: enrollment.id,
        amount: enrollment.amount / enrollment.installments,
        due_date: Bill.generate_due_date(enrollment.due_day, index)
      )
    end
  end

  def enrollment_params
    params.require(:enrollment).permit(:amount, :installments, :due_day, :student_id)
  end
end
