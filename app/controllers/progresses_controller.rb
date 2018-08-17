# frozen_string_literal: true

# コールバックを受け入れるパスを作る
class ProgressesController < ApplicationController
  def create
    # メールを送信する（SendGird使用）
    # MailSender.send_mail('text mail', params)

    # メールを送信（SMTPサーバ使用）
    EmailMailer.deliver_email(subject: 'text mail')
  end

  def destroy
    # メールを送信する（SendGird使用）
    # MailSender.send_mail('text mail', params)

    # メールを送信（SMTPサーバ使用）
    EmailMailer.deliver_email(subject: 'text mail')
  end
end
