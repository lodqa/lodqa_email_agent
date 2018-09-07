# frozen_string_literal: true

# コールバックを受け入れるパスを作る
class EventsController < ApplicationController
  def create
    # イベントの取得
    event = params[:event]
    # 送信先メールアドレスの取得
    to_email = params[:mail_id]
    # イベントで判別し、開始・終了のメール送信を行う
    case event
    when 'start' then
      # 開始メールを送信（SMTPサーバ使用）
      StartMailer.deliver_email('start mail', to_email)
    when 'finish' then
      # メール本文の取得
      param_answers = params[:answers]
      body = param_answers.blank? ? '' : param_answers.as_json
      # 終了メールを送信（SMTPサーバ使用）
      FinishMailer.deliver_email('finish mail', to_email, body)
    end
  end
end
