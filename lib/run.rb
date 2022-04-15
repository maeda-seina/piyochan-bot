# frozen_string_literal: true

require_relative '../lib/channel_info'
require_relative '../lib/bot_message_formatter'
require_relative '../lib/bot_message'

channel = ChannelInfo.new.choose
message = BotMessageFormatter.new(channel)
BotMessage.create(message.format)
