# frozen_string_literal: true

require 'net/imap'
require 'mail'

# メールを受信する
module MailReceiver
  ADDRESS = 'imap.gmail.com'
  USESSL = true
  PORT = 993

  def self.receive_mail
    # imapの接続とログイン
    imap = Net::IMAP.new(ADDRESS, PORT, USESSL)
    imap.login(ENV['GMAIL_USER_NAME'], ENV['GMAIL_PASSWORD'])
    # メールボックスを選択
    imap.select('INBOX')
    # 未読(UNSEEN)のみ取得する
    ids = imap.search(['UNSEEN'])
    return [] if ids.empty?
    imap.fetch(ids, 'RFC822').map do |m|
      mail = Mail.new(m.attr['RFC822'])
      email = mail.reply_to ? mail.reply_to[0] : mail.from[0]
      body = mail.text_part.decoded
      { email: email, body: body.chomp }
    end
  end
end
