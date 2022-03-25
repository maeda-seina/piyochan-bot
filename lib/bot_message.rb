# frozen_string_literal: true

require_relative 'bot_message_formatter'

class BotMessage
  class << self
    def create(description = nil)
      DiscordApi.create_message(BotMessage.message, BotMessageFormatter.new.create_embed_message(embed_description: description))
    end

    def message
      BotMessageFormatter::MESSAGE
    end
  end
end
