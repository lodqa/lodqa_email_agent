# frozen_string_literal: true

# 失敗メール送信
class FailureMailer < ActionMailer::Base
  default from: ENV.fetch('FROM_EMAIL', nil)

  def self.deliver_email(subject, to_email)
    build_email(subject, to_email).deliver_now
  end

  def build_email(subject, to_email)
    mail(to: to_email, subject: subject, &:text)
  end
end
