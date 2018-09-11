# frozen_string_literal: true

# 開始メール送信
class StartMailer < ActionMailer::Base
  default from: ENV['FROM_EMAIL']

  def self.deliver_email(subject, to_email, query, search_id)
    build_email(subject, to_email, query, search_id).deliver_now
  end

  def build_email(subject, to_email, query, search_id)
    @query = query
    @search_id = search_id
    mail(to: to_email, subject: subject, &:text)
  end
end
