# frozen_string_literal: true

require 'discordrb'
require 'dotenv/load'

class ChannelInfo
  class << self
    def call_channels_api
      Discordrb::API::Server.channels(ENV['DISCORD_BOT_TOKEN'],
                                      ENV['DISCORD_SERVER_ID'])
    end

    def parse
      JSON.parse(ChannelInfo.call_channels_api)
    end
  end
end
