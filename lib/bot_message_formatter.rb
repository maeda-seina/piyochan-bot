# frozen_string_literal: true

class BotMessageFormatter
  EMBED_TITLE = '本日のチャンネル紹介'

  def initialize(channels)
    @channels = channels
  end

  def run
    {
      title: EMBED_TITLE,
      description: format_embed_description,
      color: 3_066_993
    }
  end

  private

  def select_text_channels
    @channels.select { |c| (c['type']).zero? }
  end

  def text_channel_name
    select_hobby_category_channel['name']
  end

  def text_channel_topic
    select_hobby_category_channel['topic']
  end

  def topic_message
    "\n説明： #{text_channel_topic}"
  end

  def text_channel_url
    "https://discord.com/channels/#{select_hobby_category_channel['guild_id']}/#{select_hobby_category_channel['id']}"
  end

  def format_embed_description
    description = "チャンネル名： [##{text_channel_name}](#{text_channel_url})"
    description += topic_message unless text_channel_topic.nil?
    description
  end

  def select_hobby_category
    @channels.select { |channel| channel['name'].include?('趣味') }
  end

  def hobby_category_id
    select_hobby_category[0]['id']
  end

  def select_hobby_category_channel
    @channels.select { |channel| channel['parent_id'] == hobby_category_id }.sample
  end
end
