# frozen_string_literal: true

# 開始メール送信
class StartMailer < ActionMailer::Base
  default from: ENV['FROM_EMAIL']

  def self.deliver_email(subject, to_email)
    build_email(subject, to_email).deliver_now
  end

  def build_email(subject, to_email)
    @body = 'Searching the query have been starting.'
    mail(to: to_email, subject: subject, &:text)
  end
end
