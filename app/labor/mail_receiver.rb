# frozen_string_literal: true

require 'mail'
require 'net/pop'

# メールを受信する
module MailReceiver
  ADDRESS = 'pop.gmail.com'
  USESSL = true
  PORT = 995

  def self.receive_mail
    # popの接続
    Mail.defaults do
      retriever_method :pop3, address: ADDRESS,
                              port: PORT,
                              user_name: ENV['GMAIL_USER_NAME'],
                              password: ENV['GMAIL_PASSWORD'],
                              enable_ssl: USESSL
    end

    mails = Mail.all
    mail_body_array = []
    mail_body_hash = {}

    return [] if mails.empty?
    mails.each do |mail|
      # 受信メール内容
      body = mail.text_part.decoded
      email = mail.reply_to ? mail.reply_to[0] : mail.from[0]
      # メールアドレスと本文内容をハッシュ化
      mail_body_hash = { email: email, body: body.chomp }
      # ハッシュを配列に追加
      mail_body_array.push(mail_body_hash)
    end
    # メールアドレスと本文内容の配列
    mail_body_array
  end
end
