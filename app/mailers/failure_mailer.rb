# frozen_string_literal: true

# 失敗メール送信
class FailureMailer < ActionMailer::Base
  default from: ENV['FROM_EMAIL']

  def self.deliver_email(subject, body)
    # 送信先メールアドレスの取得
    to_email = ENV['FROM_EMAIL']

    build_email(subject, to_email, body).deliver_now
  end

  def build_email(subject, to_email, body)
    @body = body
    mail(to: to_email, subject: subject, &:text)
  end
end
