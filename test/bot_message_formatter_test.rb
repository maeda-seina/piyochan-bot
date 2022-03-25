require_relative '../lib/discord_api'
require_relative '../lib/bot_message'
require_relative '../lib/bot_message_formatter'
require_relative '../lib/channel_info'
require_relative 'test_helper'

class BotMessageFormatterTest < Minitest::Test

  def setup
    VCR.use_cassette('discord_api') do
      all_channels = Discordrb::API::Server.channels(ENV['DISCORD_BOT_TOKEN'],
                                                     ENV['DISCORD_SERVER_ID'])
      @all_parse_channels = JSON.parse(all_channels)
    end
  end

  def test_not_include_private_text_channel
    VCR.use_cassette('discord_api') do
      assert_empty(select_hobby_category_channels.reject { |channel| channel['permission_overwrites'].empty? })
    end
  end

  def test_include_private_channel
    VCR.use_cassette('discord_api') do
      refute_empty(@all_parse_channels.reject { |channel| channel['permission_overwrites'].empty? })
    end
  end

  def test_not_include_minute_report_channel
    VCR.use_cassette('discord_api') do
      assert_empty(select_hobby_category_channels.select { |channel| channel['name'].include?('分報') })
    end
  end

  def test_include_minute_report_channel
    VCR.use_cassette('discord_api') do
      refute_empty(@all_parse_channels.select { |channel| channel['name'].include?('分報') })
    end
  end

  private

  def select_hobby_category
    @all_parse_channels.select { |channel| channel['name'].include?('趣味') }
  end

  def hobby_category_id
    select_hobby_category[0]['id']
  end

  def select_hobby_category_channels
    @all_parse_channels.select { |channel| channel['parent_id'] == hobby_category_id }
  end
end
