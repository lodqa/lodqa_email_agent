# frozen_string_literal: true

require 'mail'

# メールを受信する
module MailReceiver
  def self.receive_mail
    # popの接続
    Mail.defaults do
      retriever_method :pop3, address: ENV['POP_ADDRESS'],
                              port: ENV['POP_PORT'],
                              user_name: ENV['POP_USERNAME'],
                              password: ENV['POP_PASSWORD'],
                              enable_ssl: ENV['POP_USESSL'] != 'true'
    end

    puts "Conncet to HOST:#{ENV['POP_ADDRESS']}:#{ENV['POP_PORT']} USER:#{ENV['POP_USERNAME']}/#{ENV['POP_PASSWORD']}"
    mails = Mail.find_and_delete(what: :first)
    puts "#{mails.length} mails recieved."
    return [] if mails.empty?

    mails.map do |mail|
      # 受信メール内容
      subject = mail.subject
      email = mail.reply_to ? mail.reply_to[0] : mail.from[0]
      # メールアドレスとタイトルをハッシュ化
      { reply_to: email, query: subject }
    end
  end
end
