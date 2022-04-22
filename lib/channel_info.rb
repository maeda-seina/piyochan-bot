# frozen_string_literal: true

require_relative 'discord_api'

class ChannelInfo
  attr_reader :channels
  def initialize
    @channels = JSON.parse(call_all_channel_api)
  end

  def choose
    select_hobby_category_channel
  end

  private

  def call_all_channel_api
    DiscordApi.fetch_all_channels
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
