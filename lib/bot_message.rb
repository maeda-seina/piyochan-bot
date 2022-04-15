# frozen_string_literal: true

class BotMessage
  MESSAGE = 'こんにちは！今日オススメのチャンネルを紹介をするよ〜'

  class << self
    def create(message)
      DiscordApi.create_message(MESSAGE,
                                message)
    end
  end
end
