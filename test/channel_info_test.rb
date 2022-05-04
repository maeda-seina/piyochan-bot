# frozen_string_literal: true

require_relative '../lib/channel_info'
require 'minitest/autorun'
require 'webmock/minitest'

class ChannelInfoTest < Minitest::Test
  include WebMock::API

  def setup
    WebMock.disable_net_connect!
    stub_request(:get, 'https://discord.com/api/v6/guilds/933233655172726845/channels')
      .with(headers: channel_header)
      .to_return(status: 200, body: channel_body.to_json, headers: {})
  end

  def teardown
    WebMock.allow_net_connect!
  end

  def test_select_hobby_category_channel
    assert_equal hobby_category_channel, ChannelInfo.new.choose
  end

  private

  def channel_header
    {
      'Accept' => '*/*',
      'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'Host' => 'discord.com',
      'User-Agent' => 'DiscordBot (https://github.com/shardlab/discordrb, v3.4.0) rest-client/2.1.0 ruby/3.1.1p18 discordrb/3.4.0',
      'X-Ratelimit-Precision' => 'millisecond'
    }
  end

  # 趣味カテゴリー、趣味カテゴリーチャンネル、他のカテゴリー、他のカテゴリーチャンネル、プライベートチャンネルを含むカテゴリー、プライベートチャンネル、分報カテゴリー、分報チャンネル
  def channel_body
    [
      # 趣味カテゴリー
      { id: '933233655172726846', type: 4, name: '趣味', position: 11, guild_id: '933233655172726845',
        permission_overwrites: [] },
      # 趣味カテゴリーチャンネル
      { id: '943713981581910036', last_message_id: '956778837360934972', type: 0, name: 'ruby', position: 19, parent_id: '933233655172726846',
        topic: "rubyについていろいろお話ししましょう〜\nhttps://www.ruby-lang.org/ja/", guild_id: '933233655172726845', permission_overwrites: [], rate_limit_per_user: 0, nsfw: false },
      # お知らせカテゴリー
      { id: '951639452927807499', type: 4, name: 'お知らせ', position: 0, parent_id:
        nil, guild_id: '933233655172726845', permission_overwrites: [] },
      # お知らせカテゴリーのチャンネル
      { id: '933233655172726848', last_message_id: '950983610180182048',
        type: 0, name: '全体のお知らせ', position: 0, parent_id: '951639452927807499', topic: 'generalチャンネルです。',
        guild_id: '933233655172726845', permission_overwrites: [], rate_limit_per_user: 0, nsfw: false },
      # プライベートカテゴリ
      { id: '951645520357621780', type: 4, name: '企業×フィヨルド',
        position: 9, parent_id: nil, guild_id: '933233655172726845', permission_overwrites: [] },
      # プライベートチャンネル
      { id: '951647258775027782',
        last_message_id: nil, type: 0, name: '株式会社xxさん',
        position: 15, parent_id: '951645520357621780', topic: nil, guild_id: '933233655172726845', permission_overwrites: [{ id: '933233655172726845', type: 'role', allow: 0, deny: 1024, allow_new: '0', deny_new: '1024' }],
        rate_limit_per_user: 0, nsfw: false },
      # 分報カテゴリー
      { id: '951645972944011265', type: 4, name: 'M（ひとりごと・分報）',
        position: 13, parent_id: nil, guild_id: '933233655172726845', permission_overwrites: [] },
      # 分報チャンネル
      { id: '951648168167239740', last_message_id: nil, type: 0, name: 'maeda🛌', position: 21, parent_id: '951645972944011265', topic: nil,
        guild_id: '933233655172726845', permission_overwrites: [], rate_limit_per_user: 0, nsfw: false }
    ]
  end

  def hobby_category_channel
    {"id"=>"943713981581910036", "last_message_id"=>"956778837360934972", "type"=>0, "name"=>"ruby", "position"=>19, "parent_id"=>"933233655172726846", "topic"=>"rubyについていろいろお話ししましょう〜\nhttps://www.ruby-lang.org/ja/", "guild_id"=>"933233655172726845", "permission_overwrites"=>[], "rate_limit_per_user"=>0, "nsfw"=>false}
  end
end
