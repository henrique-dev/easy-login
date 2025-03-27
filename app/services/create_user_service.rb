class CreateUserService < BaseService
  def call(params:)
    contract = NewUserContract.call(params.to_h)

    User.create(contract)
  end
end
