# frozen_string_literal: true

# コールバックを受け入れるパスを作る
class EventsController < ApplicationController
  def create
    # イベントの取得
    event = params[:event]
    return render status: 400 if event.blank?
    # 送信先メールアドレス・検索ID・クエリーの取得
    to_email = params[:mail_id]
    search_id = params[:search_id]
    subject = params[:query][0, 130]
    # オプション情報の取得
    options = {}
    options[:read_timeout] = params[:read_timeout]
    options[:sparql_limit] = params[:sparql_limit]
    options[:answer_limit] = params[:answer_limit]
    options[:cache] = params[:cache]
    # イベントで判別し、開始・終了のメール送信を行う
    case event
    when 'start' then
      # クエリーの取得
      query = params[:query]
      # 開始メールを送信（SMTPサーバ使用）
      StartMailer.deliver_email(subject, to_email, query, search_id, options)
    when 'finish' then
      # メール本文の取得
      answers = params[:answers]
      # 回答の項目数取得
      items_count = answers.blank? ? 0 : answers.length
      # 終了メールを送信（SMTPサーバ使用）
      FinishMailer.deliver_email(subject, to_email, items_count, search_id)
    else
      logger.info('イベント「'"#{event}"'」は想定していないイベントです。')
    end
  end
end
