# frozen_string_literal: true

# 開始メール送信
class StartMailer < ActionMailer::Base
  default from: ENV['FROM_EMAIL']

  def self.deliver_email(subject, to_email, query, search_id, expiration_date, options)
    build_email(subject, to_email, query, search_id, expiration_date, options).deliver_now
  end

  def build_email(subject, to_email, query, search_id, expiration_date, options)
    @query = query
    @search_id = search_id
    @expiration_date = expiration_date.in_time_zone('UTC').strftime('%Y/%m/%d %H:%M')
    @options = options
    mail(to: to_email, subject: subject, &:text)
  end
end
