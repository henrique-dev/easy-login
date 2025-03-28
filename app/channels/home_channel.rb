class HomeChannel < ApplicationCable::Channel
  def subscribed
    stream_from("home_channel_#{current_user.id}")
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
