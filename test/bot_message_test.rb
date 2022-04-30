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

  # そもそもこのテストは何をやりたい？一番そこが曖昧な気がする。
  # 何をテストしたい？
  # → BotMessageのcreateメソッド!!
  # BotMessageのcreateメソッドは何をやってる？
  # → Discordにpost飛ばしてる。
  def test_post_message
    message_url = "#{Discordrb::API.api_base}/channels/#{ENV['DISCORD_CHANNEL_ID']}/messages"
    # stub_request → postした結果をstubしてる。
    # postした結果とは？ → message_url（ここではrandomチャンネルへのアクセス）へbodyをpostした結果。
    # BotMessage.create(formatter)でcreateしたpostの結果と同じ結果だったらOKという内容
    # hash_includingは指定したkeyとvalueの組以外のものは無視してくれる。という認識。
    # エラーが出るというのは、BotMessage.create(formatter)でbodyの中身に、stubしてるbodyの中身がないってこと？
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
    <<~TEXT
      チャンネル名： [#ruby](https://discord.com/channels/933233655172726845/943713981581910036)
      説明： rubyについていろいろお話ししましょう〜
      https://www.ruby-lang.org/ja/
    TEXT
  end

  def channel
    {"id"=>"943713981581910036", "last_message_id"=>"956778837360934972", "type"=>0, "name"=>"ruby", "position"=>19, "parent_id"=>"933233655172726846", "topic"=>"rubyについていろいろお話ししましょう〜\nhttps://www.ruby-lang.org/ja/", "guild_id"=>"933233655172726845", "permission_overwrites"=>[], "rate_limit_per_user"=>0, "nsfw"=>false}
  end
end
