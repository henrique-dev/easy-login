class HomeController < ApplicationController
  skip_before_action :authenticate # TODO: remove this line

  def show
    @user = User.create(name: 'Paulo Bacelar', email: 'henrique.phgb@gmail.com', password: 'ZXDas7966mby@@')

    session[:user_id] = @user.id
    cookies.signed[:user_id] = @user.id

    # change the ip_address for: request.remote_ip
    RetrieveUserLocationJob.set(wait: 5.seconds).perform_later(@user.id, '131.72.49.152')
  end
end
