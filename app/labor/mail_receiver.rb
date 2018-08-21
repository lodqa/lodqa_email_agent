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
    # 全てのメールを取得
    ids = imap.search(['ALL'])

    imap.fetch(ids, 'RFC822').map { |m| Mail.new(m.attr['RFC822']) }
  end
end
