## Piyochan-bot
`Piyochan-bot`（`ピヨちゃんボット`）は毎日1回Discordサーバー内のチャンネル紹介をしてくれるフィヨルドブートキャンプ用Discord botです。

## 開発環境
Ruby 3.1.1

## 機能概要

- 「趣味」カテゴリーのテキストチャンネルからランダムに一つ選んで、任意のチャンネルでbotがチャンネル紹介してくれます。

- チャンネル名はそのチャンネルへのリンクになっています。

- 説明の行は、チャンネルトピックに記載された内容が表示されます。（チャンネルトピックに内容の記載がない場合は、説明の行は表示されない）

**イメージ画像**

[![Image from Gyazo](https://i.gyazo.com/cedf61c4ab29f33f8f949409090a0bdf.png)](https://gyazo.com/cedf61c4ab29f33f8f949409090a0bdf)

## セットアップ

### Botの作成と使用したいサーバーへの招待

[Discord Developer Portal — My Applications](https://discord.com/developers/applications/) でbotを作成する。

作成したbotを使用したいサーバーに招待する。

（詳しくは [Botアカウント作成](https://discordpy.readthedocs.io/ja/latest/discord.html) を参考にしてください）

### インストール

`git clone https://github.com/maeda-seina/piyochan-bot.git`

`cd piyochan-bot`

`bundle install`

`touch .env`

→ 環境変数をenvファイルに書き込む

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

## Herokuへのデプロイ

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
