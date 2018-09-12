# frozen_string_literal: true

require 'mail'

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
                              user_name: ENV['POP_USERNAME'],
                              password: ENV['POP_PASSWORD'],
                              enable_ssl: USESSL
    end

    puts "Conncet to HOST:#{ADDRESS}:#{PORT} USER:#{ENV['POP_USERNAME']}/#{ENV['POP_PASSWORD']}"
    mails = Mail.all
    puts "#{mails.length} mails recieved."
    return [] if mails.empty?

    mails.map do |mail|
      # 受信メール内容
      body = mail.subject
      email = mail.reply_to ? mail.reply_to[0] : mail.from[0]
      # メールアドレスと本文内容をハッシュ化
      { email: email, body: body.chomp }
    end
  end
end
