# frozen_string_literal: true

require 'net/imap'
require 'mail'

# メールを受信する
module MailReceiver
  def self.receive_mail
    @address = 'imap.gmail.com'
    @usessl = true
    @port = 993

    # imapの接続とログイン
    imap = Net::IMAP.new(@address, @port, @usessl)
    imap.login(ENV['GMAIL_USER_NAME'], ENV['GMAIL_PASSWORD'])
    # メールボックスを選択
    imap.select('INBOX')
    # 全てのメールを取得
    ids = imap.search(['ALL'])

    imap.fetch(ids, 'RFC822').each do |mail|
      m = Mail.new(mail.attr['RFC822'])
      @subject = m.subject.encode
      # multipartなメールかチェック
      if m.multipart?
        # plantextなメールかチェック
        if m.text_part
          @body = m.text_part.decoded
        # htmlなメールかチェック
        elsif m.html_part
          @body = m.html_part.decoded
        end
      else
        @body = m.body
      end
    end
  end
end
