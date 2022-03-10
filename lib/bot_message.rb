# frozen_string_literal: true

require_relative 'bot_message_formatter'

class BotMessage
  class << self
    def run
      Discordrb::Bot.new(token: ENV['DISCORD_BOT_TOKEN'],
                         client_id: ENV['DISCORD_CLIENT_ID']).run
    end

    def create
      Discordrb::API::Channel.create_message(ENV['DISCORD_BOT_TOKEN'],
                                             ENV['DISCORD_RANDOM_CHANNEL_ID'],
                                             BotMessage.not_embed_message,
                                             false,
                                             BotMessage.embed_message)
    end

    def not_embed_message
      BotMessageFormatter::MESSAGE
    end

    def embed_message
      BotMessageFormatter.new.embed_message
    end
  end
end
