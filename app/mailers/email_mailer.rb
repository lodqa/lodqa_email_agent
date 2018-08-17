# frozen_string_literal: true

# メール送信
class EmailMailer < ActionMailer::Base
  default from: ENV['FROM_EMAIL']

  def self.deliver_email(subject, body)
    build_email(subject, body).deliver_now
  end

  def build_email(subject, body)
    @body = body
    to_email = ENV['TO_EMAIL']
    mail(to: to_email, subject: subject)
  end
end
