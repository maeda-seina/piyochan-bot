# frozen_string_literal: true

require_relative 'bot_message_formatter'

class BotMessage
  class << self
    def run
      DiscordApi::BOT.run
    end

    def create
      DiscordApi.create_message(BotMessage.message, BotMessage.embed_message)
    end

    def message
      BotMessageFormatter::MESSAGE
    end

    def embed_message
      BotMessageFormatter.new.create_embed_message
    end
  end
end
