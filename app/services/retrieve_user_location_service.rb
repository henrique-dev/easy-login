require 'net/http'
require 'uri'

class RetrieveUserLocationService < BaseService
  def call(user:, ip_address:)
    uri = URI("https://ipinfo.io/#{ip_address}?token=#{ENV['IPINFO_TOKEN']}")
    response = Net::HTTP.get_response(uri)

    ActionCable.server.broadcast("home_channel_#{user.id}", { location: JSON.parse(response.body) }.as_json)
  end
end
