# LODQA e-mail agent server

The agent server for e-mail interface of LODQA.
This server provide e-mail interface to query to [LODQA](http://lodqa.org/).

## Architecture

This is a Ruby on Rails web application server.
Provide a web api to register queries.

## メールフォーマット

### タイトル

タイトルは必須です。
検索開始と終了の通知メールのタイトルに使います。

### 本文

HTML形式で記載してください。
内容はINI形式で記述します。
例えば、次のように記述します。

    Which genes are associated with Endothelin receptor type B?
    read_timeout=5
    sparql_limit=100
    answer_limit=10
    cache=no
    target=QALD-BioMed

| パラメーター名      | 意味                             | 必須    |
| :----------- | :----------------------------- | :---- |
|              | 質問文                            | true  |
| read_timeout | SPARQLクエリのタイムアウト時間             | false |
| sparql_limit | 一つのanhored pgpから生成するSPARQL数の上限 | false |
| answer_limit | 一つのSPAQRQLから取得するsolutionの上限    | false |
| cache        | no を設定すると、BSに検索結果がキャッシュされません   | false |
| target       | 特定のtargetのみで検索したいときにtarget名を指定 | false |

## 設定方法

### 環境変数

プロジェクトフォルダー内の.envファイルに以下内容で環境変数を設定する

#### BSサーバーのホスト名設定

    HOST_LODQA_BS=lodqa_bs:3000

#### 自サーバーのホスト名設定

    HOST_LODQA_EMAIL_AGENT=lodqa_email_agent:3000

#### 送信元のメールアドレス設定

    FROM_EMAIL=lodemailagent@gmail.com

#### POPサーバーのホスト名設定

    POP_ADDRESS=pop.gmail.com

#### POPサーバーのポート番号設定

    POP_PORT=995

#### POPサーバーのメールアドレス設定

    POP_USERNAME=lodemailagent@gmail.com

#### POPサーバーのパスワード設定

    POP_PASSWORD=[パスワード]

#### POPサーバーのSSL使用の有無設定

    POP_USESSL=true

### config/environments

#### SMTPサーバーの設定

例えば `config/environments/development.rb` に

```rb
config.action_mailer.smtp_settings = {
  enable_starttls_auto: true,
  address: 'smtp.gmail.com',
  port: '587',
  authentication: 'plain',
  user_name: ENV['POP_USERNAME'],
  password: ENV['POP_PASSWORD']
}
```

のようにSMTPサーバーの情報を設定します。

## 開発環境の作成

開発環境のDockerイメージを作成します。
この中にLODQA BSサーバーも含まれます。

```sh
docker-compose build
```

前述の説明に従い`.env.example`を参考に`.env`ファイルを作成します。

e-mail agentサーバーを起動します。

```sh
docker-compose up
```

メールチェックコマンドを実行します。

```sh
docker-compose run --rm --service-ports lodqa_email_agent rails runner lib/check_new_mails.rb
```
