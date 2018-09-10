# frozen_string_literal: true

# 開始メール送信
class StartMailer < ActionMailer::Base
  default from: ENV['FROM_EMAIL']

  def self.deliver_email(subject, to_email, query)
    build_email(subject, to_email, query).deliver_now
  end

  def build_email(subject, to_email, query)
    @body = 'Searching the query "'"#{query}"'" have been starting.'
    mail(to: to_email, subject: subject, &:text)
  end
end
