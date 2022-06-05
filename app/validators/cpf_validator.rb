# frozen_string_literal: true

require 'cpf_cnpj'

class CpfValidator < ActiveModel::Validator
  def validate(record)
    record.errors.add :cpf, 'inválido!' unless CPF.valid?(record.cpf)
  end
end
