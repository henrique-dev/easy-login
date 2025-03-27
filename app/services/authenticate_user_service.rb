class AuthenticateUserService < BaseService
  def call(params:)
    contract = NewSessionContract.call(params.to_h)

    user = User.find_by(email: contract[:email])

    raise Errors::ServiceError.new(errors: { credentials: ['is not valid'] }) if user.nil?

    unless user.authenticate(params[:password])
      raise Errors::ServiceError.new(errors: { credentials: ['is not valid'] })
    end

    user
  end
end
