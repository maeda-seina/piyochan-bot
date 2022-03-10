require_relative '../lib/bot_message'
# require_relative '../lib/bot'
# extend Bot
# ゴール
# bin_lsみたいな実行ファイルとして使いたい。
#
# moduleではインスタンス保持できないので、bot.runができない
# p Bot.create_bot

BotMessage.create
p BotMessage.new.run
