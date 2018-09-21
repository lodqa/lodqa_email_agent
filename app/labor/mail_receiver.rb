# frozen_string_literal: true

require 'mail'

# メールを受信する
module MailReceiver
  class << self
    def receive_mail
      # popの接続
      Mail.defaults do
        retriever_method :pop3, address: Rails.configuration.pop_settings[:address],
                                port: Rails.configuration.pop_settings[:port],
                                user_name: Rails.configuration.pop_settings[:user_name],
                                password: Rails.configuration.pop_settings[:password],
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
        query_option = body_option(mail.text_part.decoded)
        # メールアドレスとタイトルとクエリーオプションをハッシュ化
        { reply_to: email, query: subject, query_option: query_option }
      end
    end

    private

    # 本文情報でクエリのオプション値として設定
    def body_option(body)
      option = IniFile.new(content: body)
      option[:global]
    rescue IniFile::Error
      puts "The body(#{body}) could not be parsed as ini format."
      {}
    end
  end
end
