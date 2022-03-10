require 'discordrb'
require 'dotenv/load'

# ゴール
# Discordサーバーからチャンネル情報を取得する

class ChannelInfo
  # def initialize
  #   # channelの情報なので、Bot.newは必要ないかもしれない。
  #   # @bot = Discordrb::Bot.new(token: ENV['DISCORD_BOT_TOKEN'],
  #   #                           client_id: ENV['DISCORD_CLIENT_ID'])
  #   @channels = Discordrb::API::Server.channels(ENV['DISCORD_BOT_TOKEN'],
  #                                               ENV['DISCORD_SERVER_ID'])
  # end
  #
  # def parse
  #   JSON.parse(@channels)
  # end
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
