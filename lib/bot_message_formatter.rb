# frozen_string_literal: true

class BotMessageFormatter
  EMBED_TITLE = '本日のチャンネル紹介'
  MESSAGE = 'こんにちは！今日オススメのチャンネルを紹介をするよ〜'
  private_constant :EMBED_TITLE, :MESSAGE

  def initialize(channel)
    @channel = channel
  end

  def message
    MESSAGE
  end

  def embed_message
    {
      title: EMBED_TITLE,
      description: format_embed_description,
      color: 0x2ECC71
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
    "説明： #{text_channel_topic}"
  end

  def text_channel_url
    "https://discord.com/channels/#{@channel['guild_id']}/#{@channel['id']}"
  end

  def text_channel_name_and_url
    "チャンネル名： [##{text_channel_name}](#{text_channel_url})"
  end

  def format_embed_description
    description = []
    description << text_channel_name_and_url
    description << topic_message if text_channel_topic
    description.join("\n")
  end
end
