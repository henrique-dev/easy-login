class UserRegistrationsController < ApplicationController
  layout 'registration'

  skip_before_action :authenticate

  def new
    @user = User.new
  end

  def create
    @success, @user, @errors = CreateUserService.call(params: post_params).result

    if @success
      redirect_to sign_in_path
    else
      @user = User.new(post_params)
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.fetch(:user, {}).permit(:name, :email, :password)
  end
end
