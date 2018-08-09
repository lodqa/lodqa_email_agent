# frozen_string_literal: true

# コールバックを受け入れるパスを作る
class ProgressesController < ApplicationController
  def create
    # メールを送信する
    MailSender.send_mail('text mail', params)
  end

  def destroy
    # メールを送信する
    MailSender.send_mail('text mail', params)
  end
end
