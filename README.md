# LODQA e-mail agent server

The agent server for e-mail interface of LODQA.
This server provide e-mail interface to query to [LODQA](http://lodqa.org/).

## Architecture

This is a Ruby on Rails web application server.
Provide a web api to register queries.

## プロジェクトフォルダー内の.envファイルに以下内容で環境変数を設定する

* サーバの設定 HOST_LODQA_BS=lodqa_bs:3000

* クライアントの設定 HOST_LODQA_EMAIL_AGENT=lodqa_email_agent:3000

* 送信元のメールアドレス設定 FROM_EMAIL=lodemailagent@gmail.com

* 接続するメールサーバー(gmail)のメールアドレス設定
* メールアカウントの2 段階認証プロセスを有効にする
* （https://support.google.com/accounts/answer/185839?hl=ja&ref_topic=2954345）
  GMAIL_USER_NAME=lodemailagent@gmail.com

* 接続するメールサーバー(gmail)のパスワード設定
* アプリ パスワードの生成して16桁のパスワードを設定する
* （https://support.google.com/accounts/answer/185833?hl=ja）
  GMAIL_PASSWORD=[16桁のパスワード]
