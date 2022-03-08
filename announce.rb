# frozen_string_literal: true

require 'discordrb'
require 'dotenv/load'

bot = Discordrb::Bot.new(token: ENV['DISCORD_BOT_TOKEN'],
                         client_id: ENV['DISCORD_CLIENT_ID'])

channels = Discordrb::API::Server.channels(ENV['DISCORD_BOT_TOKEN'],
                                           ENV['DISCORD_SERVER_ID'])
channels = JSON.parse(channels)
text_channels = channels.select { |c| (c['type']).zero? }
random_index = rand(0...text_channels.count)
text_channel = text_channels[random_index]
text_channel_name = text_channel['name']
text_channel_topic = text_channel['topic']
message = "本日のチャンネル紹介\nチャンネル名： ##{text_channel_name}"
topic_message = "\n説明： #{text_channel_topic}"
message += topic_message unless text_channel_topic.nil?

Discordrb::API::Channel.create_message(ENV['DISCORD_BOT_TOKEN'],
                                       ENV['DISCORD_RANDOM_CHANNEL_ID'],
                                       message)

bot.run
