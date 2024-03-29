# frozen_string_literal: true

# コールバックを受け入れるパスを作る
class EventsController < ApplicationController
  def create
    # イベントの取得
    event = params[:event]
    return render status: :bad_request if event.blank?

    # 件名・送信先メールアドレス・検索ID・有効期限の取得
    subject = "Re: #{URI.decode_www_form_component(params[:mail_subject_id])[0, 130]}"
    to_email = params[:mail_address_id]
    search_id = params[:search_id]
    expiration_date = params[:expiration_date]
    # イベントで判別し、開始・終了のメール送信を行う
    case event
    when 'start'
      # クエリーの取得
      query = params[:query]
      # オプション情報の取得
      options = parse_options(params)
      # 開始メールを送信（SMTPサーバ使用）
      StartMailer.deliver_email(subject, to_email, query, search_id, expiration_date, options)
    when 'finish'
      # メール本文の取得
      answers = params[:answers]
      # 回答の項目数取得
      items_count = answers.blank? ? 0 : answers.length
      # 終了メールを送信（SMTPサーバ使用）
      FinishMailer.deliver_email(subject, to_email, items_count, search_id, expiration_date)
    else
      logger.info('イベント「'"#{event}"'」は想定していないイベントです。')
    end
  end

  private

  # オプション情報の取得
  def parse_options(params)
    options = {}
    options[:read_timeout] = params[:read_timeout]
    options[:sparql_limit] = params[:sparql_limit]
    options[:answer_limit] = params[:answer_limit]
    options[:cache] = params[:cache]
    options[:target] = params[:target] if params[:target].present?
    options
  end
end
