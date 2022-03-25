# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/discord_api'
require_relative '../lib/channel_info'
require_relative '../lib/bot_message_formatter'
require_relative '../lib/bot_message'
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
    message_url = "#{Discordrb::API.api_base}/channels/#{ENV['DISCORD_RANDOM_CHANNEL_ID']}/messages"
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
    チャンネル名： [#ruby](https://discord.com/channels/933233655172726845/943713981581910036)\n説明： rubyについていろいろお話ししましょう〜\nhttps://www.ruby-lang.org/ja/
    TEXT
  end
end
