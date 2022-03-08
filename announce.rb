require 'discordrb'
require 'dotenv/load'

bot = Discordrb::Bot.new(token: ENV['DISCORD_BOT_TOKEN'],
                         client_id: ENV['DISCORD_CLIENT_ID'])

channels = Discordrb::API::Server.channels(ENV['DISCORD_BOT_TOKEN'],
                                           ENV['DISCORD_SERVER_ID'])
channels = JSON.parse(channels)
text_channels = channels.select { |c| (c['type']).zero? }
ramdom_index = rand(0...text_channels.count)
text_channel = text_channels[ramdom_index]
p text_channel_name = text_channel['name']
p text_channel_topic = text_channel['topic']
bot.run
