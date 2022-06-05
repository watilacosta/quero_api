# frozen_string_literal: true

class DueDateValidator < ActiveModel::Validator
  def validate(record)
    record.errors.add :due_date, 'invalid' unless due_date_valid?(record.due_date)
  end

  private

  def due_date_valid?(due_date)
    return false unless due_date.present?

    due_date.to_date.is_a?(Date)
  end
end
