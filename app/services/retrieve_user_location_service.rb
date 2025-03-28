require 'net/http'
require 'uri'

class RetrieveUserLocationService < BaseService
  def call(user:, ip_address:)
    success, data = retrieve_location(ip_address)

    if success
      send_notification(user, { location: data }.as_json)
    else
      send_notification(user, nil)

      raise Errors::ServiceError.new(errors: { ip_address: [data.dig('error', 'message')] })
    end
  end

  private

  def retrieve_location(ip_address)
    uri = URI("https://ipinfo.io/#{ip_address}?token=#{ENV['IPINFO_TOKEN']}")
    response = Net::HTTP.get_response(uri)

    [response.is_a?(Net::HTTPSuccess), JSON.parse(response.body)]
  rescue StandardError
    [false, { 'error' => { 'message' => 'cannot retrieve the location' } }]
  end

  def send_notification(user, location)
    ActionCable.server.broadcast("home_channel_#{user.id}", location)
  end
end
