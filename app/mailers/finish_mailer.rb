# frozen_string_literal: true

# 終了メール送信
class FinishMailer < ActionMailer::Base
  default from: ENV['FROM_EMAIL']

  def self.deliver_email(subject, to_email, body)
    build_email(subject, to_email, body).deliver_now
  end

  def build_email(subject, to_email, body)
    @body = body.blank? ? 'No answer was found.' : JSON.pretty_generate(body)
    mail(to: to_email, subject: subject, &:text)
  end
end
