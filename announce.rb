require 'discordrb'
require 'dotenv/load'

bot = Discordrb::Bot.new(token: ENV['DISCORD_BOT_TOKEN'],
                         client_id: ENV['DISCORD_CLIENT_ID'])

channels = Discordrb::API::Server.channels(ENV['DISCORD_BOT_TOKEN'],
                                           ENV['DISCORD_SERVER_ID'])
channels = JSON.parse(channels)
p text_channels = channels.select { |c| (c['type']).zero? }

bot.run
