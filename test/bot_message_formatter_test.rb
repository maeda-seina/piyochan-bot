require_relative '../lib/bot_message_formatter'
require 'minitest/autorun'

class BotMessageTest < Minitest::Test
  def setup
    @formatter = BotMessageFormatter.new(channel)
  end

  def test_message
    assert_equal 'こんにちは！今日オススメのチャンネルを紹介をするよ〜', @formatter.message
  end

  def test_embed_message
    expected = expected_embed_message
    assert_equal expected, @formatter.embed_message
  end

  private

  def expected_embed_message
    {:title=>"本日のチャンネル紹介", :description=>"チャンネル名： [#ruby](https://discord.com/channels/933233655172726845/943713981581910036)\n説明： rubyについていろいろお話ししましょう〜\nhttps://www.ruby-lang.org/ja/", :color=>3066993}
  end

  def channel
    {"id"=>"943713981581910036", "last_message_id"=>"956778837360934972", "type"=>0, "name"=>"ruby", "position"=>19, "parent_id"=>"933233655172726846", "topic"=>"rubyについていろいろお話ししましょう〜\nhttps://www.ruby-lang.org/ja/", "guild_id"=>"933233655172726845", "permission_overwrites"=>[], "rate_limit_per_user"=>0, "nsfw"=>false}
  end
end
