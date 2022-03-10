require_relative 'bot_message_formatter'

class BotMessage
  def initialize
    @bot = Discordrb::Bot.new(token: ENV['DISCORD_BOT_TOKEN'],
                              client_id: ENV['DISCORD_CLIENT_ID'])
  end

  def run
    @bot.run
  end

  def self.create
    Discordrb::API::Channel.create_message(ENV['DISCORD_BOT_TOKEN'],
                                           ENV['DISCORD_RANDOM_CHANNEL_ID'],
                                           BotMessage.not_embed_message,
                                           false,
                                           BotMessage.embed_message)

  end

  def self.not_embed_message
    BotMessageFormatter::MESSAGE
  end

  def self.embed_message
    BotMessageFormatter.new.embed_message
  end
end
