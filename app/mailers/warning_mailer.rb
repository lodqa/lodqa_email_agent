# frozen_string_literal: true

# 失敗メール送信
class WarningMailer < ActionMailer::Base
  default from: ENV['FROM_EMAIL']

  def self.deliver_email(subject, to_email)
    build_email(subject, to_email).deliver_now
  end

  def build_email(subject, to_email)
    mail(to: to_email, subject: subject, &:text)
  end
end
