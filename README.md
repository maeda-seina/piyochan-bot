## Piyochan-bot
`Piyochan-bot`（`ピヨちゃんボット`）は毎日1回Discordサーバー内のチャンネル紹介をしてくれるDiscord botです。

## 開発環境
Ruby 3.1.1

## セットアップ

[Discord Developer Portal — My Applications](https://discord.com/developers/applications/) でbotを作成
（もう少し詳しく記載する）

`git clone https://github.com/maeda-seina/piyochan-bot.git`

`cd piyochan-bot`

`bundle install`

`touch .env`

環境変数をenvファイルに書き込む

| 環境変数               | 内容                     |
|--------------------|------------------------|
| DISCORD_BOT_TOKEN  | Discord BotのToken      |
| DISCORD_SERVER_ID  | Botを招待するDiscordサーバーのID |
| DISCORD_CHANNEL_ID | メッセージを送信したいチャンネルのID    |

（※`DISCORD_BOT_TOKEN`については、`DISCORD_BOT_TOKEN = 'Bot YOUR_DISCORD_BOT_TOKEN'`と設定をお願いします。）

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

**CLIから設定**

```txt
heroku config:set DISCORD_BOT_TOKEN='Bot YOUR_DISCORD_BOT_TOKEN' DISCORD_SERVER_ID=YOUR_DISCORD_SERVER_ID DISCORD_CHANNEL_ID=YOUR_DISCORD_CHANNEL_ID
```

（※`DISCORD_BOT_TOKEN`については、`DISCORD_BOT_TOKEN = 'Bot YOUR_DISCORD_BOT_TOKEN'`と設定をお願いします。）

**Herokuのサイトで環境変数を設定**

1. Herokuにログインする サイトからHerokuにログインして、対象のアプリを選択する。
2. settingタブをクリックする
3. Config VarsのRevel Config Varsをクリック
4. KEYとVALUEを入力して保存する（※）

（※DISCORD_BOT_TOKENについて）

`DISCORD_BOT_TOKEN`のKEYに対するVALUEに関して、`Bot YOUR_DISCORD_BOT_TOKEN`と設定するようお願いします。

### 定期実行

Herokuスケジューラーを設定する
