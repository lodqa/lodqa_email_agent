# frozen_string_literal: true

# 終了メール送信
class FinishMailer < ActionMailer::Base
  default from: ENV['FROM_EMAIL']

  def self.deliver_email(subject, to_email, items_count, search_id)
    build_email(subject, to_email, items_count, search_id).deliver_now
  end

  def build_email(subject, to_email, items_count, search_id)
    @items_count = items_count
    @search_id = search_id
    mail(to: to_email, subject: subject, &:text)
  end
end
