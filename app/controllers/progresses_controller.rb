# frozen_string_literal: true

# コールバックを受け入れるパスを作る
class ProgressesController < ApplicationController
  def create
    to_email = mail_progress_path.split('/')[2]
    # メールを送信（SMTPサーバ使用）
    EmailMailer.deliver_email('text mail', params, to_email)
  end

  def destroy
    # メールを送信（SMTPサーバ使用）
    EmailMailer.deliver_email('text mail', params)
  end
end
