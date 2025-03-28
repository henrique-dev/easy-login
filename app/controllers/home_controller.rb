class HomeController < ApplicationController
  def show
    RetrieveUserLocationJob.set(wait: 5.seconds).perform_later(@user.id, request.remote_ip)
  end
end
