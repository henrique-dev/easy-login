class CreateUserService < BaseService
  def call(params:)
    contract = NewUserContract.call(params.to_h)

    validate_unique_user!(contract)

    User.create(contract)
  end

  private

  def validate_unique_user!(params)
    return if User.find_by(email: params[:email]).nil?

    raise Errors::ServiceError.new(errors: { email: ['already registered'] })
  end
end
