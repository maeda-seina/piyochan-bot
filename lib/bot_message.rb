# frozen_string_literal: true

class BotMessage
  class << self
    def create(message)
      DiscordApi.create_message(BotMessageFormatter::MESSAGE,
                                message)
    end
  end
end
