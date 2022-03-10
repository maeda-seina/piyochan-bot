require_relative 'channel_info'

class BotMessageFormatter

  MESSAGE = 'こんにちは！今日オススメのチャンネルを紹介をするよ〜'
  EMBED_TITLE = '本日のチャンネル紹介'

  def initialize
    @channel_message = ChannelInfo.parse
    @text_channel = select_text_channels.sample
  end

  def select_text_channels
    @channel_message.select { |c| (c['type']).zero? }
  end

  def embed_message
    {
      title: EMBED_TITLE,
      description: description,
      color: 3_066_993
    }
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

  def description
    message = "チャンネル名： [##{text_channel_name}](#{text_channel_url})"
    message += topic_message unless text_channel_topic.nil?
    message
  end
end
