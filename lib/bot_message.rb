# frozen_string_literal: true

class BotMessage
  MESSAGE = 'こんにちは！今日オススメのチャンネルを紹介をするよ〜'

  class << self
    def create(formatter)
      DiscordApi.create_message(MESSAGE,
                                formatter)
    end
  end
end
