# frozen_string_literal: true

require_relative '../lib/discord_api'
require_relative '../lib/channel_info'
require_relative '../lib/bot_message_formatter'
require_relative '../lib/bot_message'
require 'minitest/autorun'
require 'webmock/minitest'

class BotMessageTest < Minitest::Test
  include WebMock::API

  def setup
    WebMock.disable_net_connect!
  end

  def teardown
    WebMock.allow_net_connect!
  end

  def test_post_message
    fetch_channel_url = "#{Discordrb::API.api_base}/guilds/#{ENV['DISCORD_SERVER_ID']}/channels"
    stub_request(:get, fetch_channel_url)
      .to_return(status: 200, body: [].to_json, headers: {})
    message_url = "#{Discordrb::API.api_base}/channels/#{ENV['DISCORD_CHANNEL_ID']}/messages"
    stub_message = stub_request(:post, message_url).with(body: hash_including(embed_hash))
    BotMessage.create(embed_hash_description)
    assert_requested(stub_message)
  end

  private

  def embed_hash
    {
      content: 'こんにちは！今日オススメのチャンネルを紹介をするよ〜',
      embed: {
        title: BotMessageFormatter::EMBED_TITLE,
        description: embed_hash_description,
        color: 3_066_993
      }
    }
  end

  def embed_hash_description
    <<~TEXT
      チャンネル名： [#ruby](https://discord.com/channels/933233655172726845/943713981581910036)
      説明： rubyについていろいろお話ししましょう〜
      https://www.ruby-lang.org/ja/
    TEXT
  end
end
