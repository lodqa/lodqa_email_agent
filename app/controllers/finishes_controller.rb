# frozen_string_literal: true

# コールバックを受け入れるパスを作る
class FinishesController < ApplicationController
  def create
    # 送信先メールアドレスの取得
    to_email = params[:mail_id]
    # メール本文の取得
    param_answers = params[:answers]
    body = param_answers.blank? ? '' : param_answers.as_json
    # 終了メールを送信（SMTPサーバ使用）
    FinishMailer.deliver_email('finish mail', to_email, body)
  end
end
