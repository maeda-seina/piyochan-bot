# frozen_string_literal: true

class BotMessage
  class << self
    def create(formatter)
      DiscordApi.create_message(formatter.message, formatter.embed_message)
    end
  end
end
