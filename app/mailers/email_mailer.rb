# frozen_string_literal: true

# メール送信
class EmailMailer < ActionMailer::Base
  default from: ENV['FROM_EMAIL']

  def self.deliver_email(subject:)
    build_email(subject: subject).deliver
  end

  def build_email(subject:)
    to_email = ENV['TO_EMAIL']
    mail(to: to_email, subject: subject, &:html)
  end
end
