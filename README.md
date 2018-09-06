# LODQA e-mail agent server

The agent server for e-mail interface of LODQA.
This server provide e-mail interface to query to [LODQA](http://lodqa.org/).

## Architecture

This is a Ruby on Rails web application server.
Provide a web api to register queries.

## プロジェクトフォルダー内の.envファイルに以下内容で環境変数を設定する

### サーバの設定
```
HOST_LODQA_BS=lodqa_bs:3000
```
### クライアントの設定
```
HOST_LODQA_EMAIL_AGENT=lodqa_email_agent:3000
```
### 送信元のメールアドレス設定
```
FROM_EMAIL=lodemailagent@gmail.com
```
### 接続するメールサーバーのメールアドレス設定
```
POP_USERNAME=lodemailagent@gmail.com
```
### 接続するメールサーバーのパスワード設定
```
POP_PASSWORD=[パスワード]
```
