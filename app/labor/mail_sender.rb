# frozen_string_literal: true

# using SendGrid's Ruby Library
# https://github.com/sendgrid/sendgrid-ruby
require 'sendgrid-ruby'

# メールを送信する
module MailSender
  include SendGrid

  def self.send_mail(subject, body)
    from = Email.new(email: 'lodqa-mailer@lodqa.org')
    to = Email.new(email: 'sufujj@gmail.com')
    content = Content.new(type: 'text/plain', value: body.to_s)
    mail = Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    sg.client.mail._('send').post(request_body: mail.to_json)
  end
end
