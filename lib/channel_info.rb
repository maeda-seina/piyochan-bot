# frozen_string_literal: true

require 'discordrb'
require 'dotenv/load'

class ChannelInfo
  class << self
    def get_channels
      Discordrb::API::Server.channels(ENV['DISCORD_BOT_TOKEN'],
                                      ENV['DISCORD_SERVER_ID'])
    end

    def parse
      JSON.parse(ChannelInfo.get_channels)
    end
  end
end
