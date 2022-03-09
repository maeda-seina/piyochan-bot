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
text_channel_url = "https://discord.com/channels/#{text_channel['guild_id']}/#{text_channel['id']}"
message = "チャンネル名： [##{text_channel_name}](#{text_channel_url})"
topic_message = "\n説明： #{text_channel_topic}"
message += topic_message unless text_channel_topic.nil?

embed = {
  title: '本日のチャンネル紹介',
  description: message,
  color: 3_066_993
}

Discordrb::API::Channel.create_message(ENV['DISCORD_BOT_TOKEN'],
                                       ENV['DISCORD_RANDOM_CHANNEL_ID'],
                                       'こんにちは！今日オススメのチャンネルを紹介をするよ〜',
                                       false,
                                       embed)

bot.run
