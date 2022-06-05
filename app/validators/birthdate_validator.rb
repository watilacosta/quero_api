# frozen_string_literal: true

class BirthdateValidator < ActiveModel::Validator
  def validate(record)
    birthdate = record.birthdate

    return unless birthdate.present? && birthdate > Date.today

    record.errors.add :birthdate, 'Data de aniversário deve ser anterior a data presente.'
  end
end
