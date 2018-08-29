# frozen_string_literal: true

# 開始メール送信
class StartMailer < ActionMailer::Base
  default from: ENV['FROM_EMAIL']

  def self.deliver_email(subject, body)
    build_email(subject, body).deliver_now
  end

  def build_email(subject, body)
    @body = 'Searching the query have been starting.'
    to_email = body[:mail_id]
    mail(to: to_email, subject: subject, &:text)
  end
end
