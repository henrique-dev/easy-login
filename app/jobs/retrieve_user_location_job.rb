class RetrieveUserLocationJob < ApplicationJob
  queue_as :default

  def perform(user_id, ip_address)
    user = User.find(user_id)

    return if user.nil?

    RetrieveUserLocationService.call(user:, ip_address:)
  end
end
