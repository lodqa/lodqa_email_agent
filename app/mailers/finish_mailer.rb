# frozen_string_literal: true

# 終了メール送信
class FinishMailer < ActionMailer::Base
  default from: ENV['FROM_EMAIL']

  def self.deliver_email(subject, body)
    build_email(subject, body).deliver_now
  end

  def build_email(subject, body)
    @body = body[:answers].blank? ? 'No answer was found.' : JSON.pretty_generate(body[:answers])
    to_email = body[:mail_id]
    mail(to: to_email, subject: subject, &:text)
  end
end
