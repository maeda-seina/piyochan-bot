# frozen_string_literal: true

require_relative 'discord_api'

class ChannelInfo
  def self.call_all_channel_api
    DiscordApi::ALL_CHANNELS
  end

  def self.parse
    JSON.parse(ChannelInfo.call_all_channel_api)
  end
end
