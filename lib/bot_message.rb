# frozen_string_literal: true

require_relative 'bot_message_formatter'

class BotMessage
  MESSAGE = 'こんにちは！今日オススメのチャンネルを紹介をするよ〜'

  class << self
    def create(formatter)
      DiscordApi.create_message(MESSAGE,
                                formatter)
    end
  end
end
