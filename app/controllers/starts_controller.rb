# frozen_string_literal: true

# コールバックを受け入れるパスを作る
class StartsController < ApplicationController
  def create
    # 開始メールを送信（SMTPサーバ使用）
    StartMailer.deliver_email('start mail', params)
  end
end
