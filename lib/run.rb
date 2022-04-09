# frozen_string_literal: true

require_relative '../lib/channel_info'
require_relative '../lib/bot_message_formatter'
require_relative '../lib/bot_message'

channel = ChannelInfo.choose
formatter = BotMessageFormatter.new(channel)
BotMessage.create(formatter.run)
