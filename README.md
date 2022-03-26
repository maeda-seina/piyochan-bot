## Piyochan-bot
`Piyochan-bot`（`ピヨちゃんボット`）は毎日1回Discordサーバー内のチャンネル紹介をしてくれるDiscord botです。

## 開発環境
Ruby 3.1.1

## セットアップ

[Discord Developer Portal — My Applications](https://discord.com/developers/applications/) でbotを作成

`git clone https://github.com/maeda-seina/piyochan-bot.git`

`cd piyochan-bot`

`bundle install`

`touch .env`

環境変数をenvファイルに書き込む

（環境変数について書く）

## 実行
`bundle exec ruby bin/send_message.rb`


## Lint

`bundle exec rubocop`

## Test

`bundle exec ruby test`


## デプロイ

`heroku login`

`heroku create 任意の名前`

`git push heroku main`

### 環境変数の設定
`heroku config:set `

または

herokuのサイトで環境変数を設定

### 定期実行
herokuスケジューラーを設定する
