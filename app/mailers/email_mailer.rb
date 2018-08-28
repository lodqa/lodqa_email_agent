# frozen_string_literal: true

# メール送信
class EmailMailer < ActionMailer::Base
  default from: ENV['FROM_EMAIL']

  def self.deliver_email(subject, body, to_email)
    build_email(subject, body, to_email).deliver_now
  end

  def build_email(subject, body, to_email)
    @body = body
    mail(to: to_email, subject: subject)
  end
end
