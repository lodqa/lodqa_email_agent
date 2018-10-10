# frozen_string_literal: true

# 終了メール送信
class FinishMailer < ActionMailer::Base
  default from: ENV['FROM_EMAIL']

  def self.deliver_email(subject, to_email, items_count, search_id, expiration_date)
    build_email(subject, to_email, items_count, search_id, expiration_date).deliver_now
  end

  def build_email(subject, to_email, items_count, search_id, expiration_date)
    @items_count = items_count
    @search_id = search_id
    @expiration_date = expiration_date.in_time_zone('Tokyo').strftime('%Y/%m/%d %H:%M')
    mail(to: to_email, subject: subject, &:text)
  end
end
