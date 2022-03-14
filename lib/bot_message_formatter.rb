# frozen_string_literal: true

require_relative 'channel_info'

class BotMessageFormatter
  MESSAGE = 'こんにちは！今日オススメのチャンネルを紹介をするよ〜'
  EMBED_TITLE = '本日のチャンネル紹介'

  def initialize
    @all_channels = ChannelInfo.all
    @text_channel = select_text_channels.sample
  end

  def create_embed_message
    {
      title: EMBED_TITLE,
      description: format_embed_description,
      color: 3_066_993
    }
  end

  private

  def select_text_channels
    @all_channels.select { |c| (c['type']).zero? }
  end

  def text_channel_name
    @text_channel['name']
  end

  def text_channel_topic
    @text_channel['topic']
  end

  def topic_message
    "\n説明： #{text_channel_topic}"
  end

  def text_channel_url
    "https://discord.com/channels/#{@text_channel['guild_id']}/#{@text_channel['id']}"
  end

  def format_embed_description
    description = "チャンネル名： [##{text_channel_name}](#{text_channel_url})"
    description += topic_message unless text_channel_topic.nil?
    description
  end

  def exclude_private_text_channel
    select_text_channels.select{ |channel| channel['permission_overwrites'].empty? }
  end
end

pp BotMessageFormatter.new.send(:exclude_private_text_channel)
