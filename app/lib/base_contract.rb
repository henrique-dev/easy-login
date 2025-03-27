require 'dry-validation'

class BaseContract < Dry::Validation::Contract
  def self.call(args = nil)
    base_contract = new
    contract_response = base_contract.call(args)

    if contract_response.success?
      return contract_response.to_h.map do |key, value|
        [key, base_contract.transform(key.to_s, value)]
      end.to_h
    end

    raise Errors::ServiceError.new(errors: contract_response.errors.to_h)
  end

  def transform(_key, value)
    value
  end
end
