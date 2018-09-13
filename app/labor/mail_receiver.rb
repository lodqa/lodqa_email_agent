# frozen_string_literal: true

require 'mail'

# メールを受信する
module MailReceiver
  def self.receive_mail
    # popの接続
    Mail.defaults do
      retriever_method :pop3, address: Rails.configuration.pop_settings[:address],
                              port: Rails.configuration.pop_settings[:port],
                              user_name: Rails.configuration.pop_settings[:user_name],
                              password: Rails.configuration.pop_settings[:password],
                              # 暗号化あり:true、暗号化なし:falseを指定する必要がある。
                              enable_ssl: Rails.configuration.pop_settings[:use_ssl]
    end

    puts "Conncet to HOST:#{Rails.configuration.pop_settings[:address]}:#{Rails.configuration.pop_settings[:port]}
           USER:#{Rails.configuration.pop_settings[:user_name]}/#{Rails.configuration.pop_settings[:password]}"
    mails = Mail.find_and_delete
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
