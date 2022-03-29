# frozen_string_literal: true

require_relative 'discord_api'

class ChannelInfo
  class << self
    def call_all_channel_api
      DiscordApi.fetch_all_channels
    end

    def all
      JSON.parse(ChannelInfo.call_all_channel_api)
    end
  end
end
