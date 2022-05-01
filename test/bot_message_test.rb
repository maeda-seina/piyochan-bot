# frozen_string_literal: true

require_relative '../lib/discord_api'
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
    message_url = "#{Discordrb::API.api_base}/channels/#{ENV['DISCORD_CHANNEL_ID']}/messages"
    stub_message = stub_request(:post, message_url).with(body: hash_including(embed_hash))
    formatter = BotMessageFormatter.new(channel)
    BotMessage.create(formatter)
    assert_requested(stub_message)
  end

  private

  def embed_hash
    {
      content: 'こんにちは！今日オススメのチャンネルを紹介をするよ〜',
      embed: {
        title: '本日のチャンネル紹介',
        description: embed_hash_description,
        color: 0x2ECC71
      }
    }
  end

  def embed_hash_description
    "チャンネル名： [#ruby](https://discord.com/channels/933233655172726845/943713981581910036)\n説明： rubyについていろいろお話ししましょう〜\nhttps://www.ruby-lang.org/ja/"
  end

  def channel
    {"id"=>"943713981581910036", "last_message_id"=>"956778837360934972", "type"=>0, "name"=>"ruby", "position"=>19, "parent_id"=>"933233655172726846", "topic"=>"rubyについていろいろお話ししましょう〜\nhttps://www.ruby-lang.org/ja/", "guild_id"=>"933233655172726845", "permission_overwrites"=>[], "rate_limit_per_user"=>0, "nsfw"=>false}
  end
end
