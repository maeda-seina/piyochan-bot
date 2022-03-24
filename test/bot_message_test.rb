require 'minitest/autorun'
require_relative '../lib/discord_api'
require_relative '../lib/channel_info'
require_relative '../lib/bot_message_formatter'
require_relative '../lib/bot_message'
require 'webmock/minitest'
include WebMock::API

class BotMessageTest < Minitest::Test
  def setup
    WebMock.disable_net_connect!
  end

  def teardown
    WebMock.allow_net_connect!
  end

  def test_post_message
    message_url = "#{Discordrb::API.api_base}/channels/#{ENV['DISCORD_RANDOM_CHANNEL_ID']}/messages"
    first_message = stub_request(:post, message_url)
                      .with(body: hash_including({ content: 'こんにちは！今日オススメのチャンネルを紹介をするよ〜' }))
    stub_message = stub_request(:post, message_url).with(body: hash_including(embed_hash))
    BotMessage.create
    assert_requested(first_message)
    assert_requested(stub_message)
  end

  private
  def embed_hash
    {
      embed: {
        title: BotMessageFormatter::EMBED_TITLE,
        description: BotMessageFormatter.new.send(:format_embed_description),
        color: 3_066_993
      },
    }
  end
end
