# frozen_string_literal: true

require_relative '../lib/discord_api'
require_relative '../lib/channel_info'
require_relative '../lib/bot_message_formatter'
require_relative '../lib/bot_message'
require 'minitest/autorun'
require 'webmock/minitest'

class BotMessageFormatterTest < Minitest::Test
  include WebMock::API

  def setup
    WebMock.disable_net_connect!
    stub_request(:get, 'https://discord.com/api/v6/guilds/933233655172726845/channels')
      .with(headers: channel_header)
      .to_return(status: 200, body: channel_body.to_json, headers: {})
    @channels = ChannelInfo.all
  end

  def teardown
    WebMock.allow_net_connect!
  end

  def test_include_hobby_channel
    refute_empty(@channels.reject { |channel| channel['parent_id'] == hobby_category_id })
    assert_empty(select_hobby_category_channels.reject { |channel| channel['parent_id'] == hobby_category_id })
  end

  def test_not_include_private_text_channel_in_announce_channels
    # permission_overwritesの中身があるものを排除(empty?メソッドを使った結果trueのものを排除する。false、つまり中身があるものはそのままいてもらう。)
    refute_empty(@channels.reject { |channel| channel['permission_overwrites'].empty? })
    assert_empty(select_hobby_category_channels.reject { |channel| channel['permission_overwrites'].empty? })
  end

  def test_not_include_minute_report_channel_in_announce_channels
    refute_empty(@channels.select { |channel| channel['name'].include?('分報') })
    assert_empty(select_hobby_category_channels.select { |channel| channel['name'].include?('分報') })
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

  # 趣味カテゴリーと、趣味カテゴリーのチャンネル一つと、他のカテゴリーと、他のカテゴリーのチャンネル一つと、プライベートチャンネルを含むカテゴリー、プライベートチャンネル、分報カテゴリー、分報チャンネル
  def channel_body
    [
      # 趣味カテゴリー
      { id: '933233655172726846', type: 4, name: '趣味', position: 11, parent_id: '933233655172726846', guild_id: '933233655172726845',
        permission_overwrites: [] },
      # 趣味カテゴリーチャンネル（Ruby）
      { id: '943713981581910036', last_message_id: '956778837360934972', type: 0, name: 'ruby', position: 19, parent_id: '933233655172726846',
        topic: "rubyについていろいろお話ししましょう〜\nhttps://www.ruby-lang.org/ja/", guild_id: '933233655172726845', permission_overwrites: [], rate_limit_per_user: 0, nsfw: false },
      # お知らせカテゴリー
      { id: '951639452927807499', type: 4, name: 'お知らせ', position: 0, parent_id:
        nil, guild_id: '933233655172726845', permission_overwrites: [] },
      # お知らせカテゴリーのチャンネル
      { id: '933233655172726848', last_message_id: '950983610180182048',
        type: 0, name: '全体のお知らせ', position: 0, parent_id: '951639452927807499', topic: 'generalチャンネルです。',
        guild_id: '933233655172726845', permission_overwrites: [], rate_limit_per_user: 0, nsfw: false },
      # プライベートカテゴリのチャンネル
      { id: '951645520357621780', type: 4, name: '企業×フィヨルド',
        position: 9, parent_id: nil, guild_id: '933233655172726845', permission_overwrites: [] },
      # 株式会社xxさん
      { id: '951647258775027782',
        last_message_id: nil, type: 0, name: '株式会社xxさん',
        position: 15, parent_id: '951645520357621780', topic: nil, guild_id: '933233655172726845', permission_overwrites: [{ id: '933233655172726845', type: 'role', allow: 0, deny: 1024, allow_new: '0', deny_new: '1024' }],
        rate_limit_per_user: 0, nsfw: false },
      # 分報カテゴリー
      { id: '951645972944011265', type: 4, name: 'M（ひとりごと・分報）',
        position: 13, parent_id: nil, guild_id: '933233655172726845', permission_overwrites: [] },
      # maedaの分報
      { id: '951648168167239740', last_message_id: nil, type: 0, name: 'maeda🛌', position: 21, parent_id: '951645972944011265', topic: nil,
        guild_id: '933233655172726845', permission_overwrites: [], rate_limit_per_user: 0, nsfw: false }
    ]
  end

  def select_hobby_category
    @channels.select { |channel| channel['name'].include?('趣味') }
  end

  def hobby_category_id
    select_hobby_category[0]['id']
  end

  def select_hobby_category_channels
    @channels.select { |channel| channel['parent_id'] == hobby_category_id }
  end
end
