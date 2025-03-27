class SessionsController < ApplicationController
  layout 'registration'

  skip_before_action :authenticate

  def new
    @user = User.new
  end

  def create
    @success, @user, @errors = AuthenticateUserService.call(params: post_params).result

    if @success
      session[:user_id] = @user.id
      redirect_to home_path
    else
      @user = User.new(post_params)
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.fetch(:user, {}).permit(:email, :password)
  end
end
