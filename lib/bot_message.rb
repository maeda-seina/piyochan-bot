# frozen_string_literal: true

require_relative 'bot_message_formatter'

class BotMessage
  class << self
    def create(formatter)
      DiscordApi.create_message(BotMessage::message,
                                formatter)
    end

    def message
      BotMessageFormatter::MESSAGE
    end
  end
end
