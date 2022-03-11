# frozen_string_literal: true

require 'discordrb'
require 'dotenv/load'

module DiscordApi
  BOT = Discordrb::Bot.new(token: ENV['DISCORD_BOT_TOKEN'],
                           client_id: ENV['DISCORD_CLIENT_ID'])

  ALL_CHANNELS = Discordrb::API::Server.channels(ENV['DISCORD_BOT_TOKEN'],
                                                 ENV['DISCORD_SERVER_ID'])

  def self.create_message(message, embed_message, tts: false)
    Discordrb::API::Channel.create_message(ENV['DISCORD_BOT_TOKEN'],
                                           ENV['DISCORD_RANDOM_CHANNEL_ID'],
                                           message,
                                           tts,
                                           embed_message)
  end
end
