# frozen_string_literal: true

# コールバックを受け入れるパスを作る
class ProgressesController < ApplicationController
  def create
    # メールを送信（SMTPサーバ使用）
    EmailMailer.deliver_email('text mail')
  end

  def destroy
    # メールを送信（SMTPサーバ使用）
    EmailMailer.deliver_email('text mail')
  end
end
