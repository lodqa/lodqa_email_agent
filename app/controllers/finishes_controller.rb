# frozen_string_literal: true

# コールバックを受け入れるパスを作る
class FinishesController < ApplicationController
  def create
    # 終了メールを送信（SMTPサーバ使用）
    FinishMailer.deliver_email('finish mail', params)
  end
end
