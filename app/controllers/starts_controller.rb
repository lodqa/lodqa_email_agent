# frozen_string_literal: true

# コールバックを受け入れるパスを作る
class StartsController < ApplicationController
  def create
    # 送信先メールアドレスの取得
    to_email = params[:mail_id]
    # 開始メールを送信（SMTPサーバ使用）
    StartMailer.deliver_email('start mail', to_email)
  end
end
