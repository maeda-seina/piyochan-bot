# frozen_string_literal: true

class BotMessageFormatter
  EMBED_TITLE = '本日のチャンネル紹介'
  MESSAGE = 'こんにちは！今日オススメのチャンネルを紹介をするよ〜'

  def initialize(channel)
    @channel = channel
  end

  def format
    {
      title: EMBED_TITLE,
      description: format_embed_description,
      color: 3_066_993
    }
  end

  private

  def text_channel_name
    @channel['name']
  end

  def text_channel_topic
    @channel['topic']
  end

  def topic_message
    "\n説明： #{text_channel_topic}"
  end

  def text_channel_url
    "https://discord.com/channels/#{@channel['guild_id']}/#{@channel['id']}"
  end

  def format_embed_description
    description = "チャンネル名： [##{text_channel_name}](#{text_channel_url})"
    description += topic_message unless text_channel_topic.nil?
    description
  end
end
