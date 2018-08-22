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

    questions = query_value(imap, ids)
    questions.compact! if questions.present?
  end

  def self.query_value(imap, ids)
    imap.fetch(ids, 'RFC822').map do |m|
      mail = Mail.new(m.attr['RFC822'])
      body = nil
      if mail.multipart?
        # plantextなメールかチェック
        if mail.text_part
          body = mail.text_part.decoded
        # htmlなメールかチェック
        elsif mail.html_part
          body = mail.html_part.decoded
        end
      else
        body = mail.body
      end
      if body.include?('query')
        query_value = body.gsub(/[{\"}]/, '')
        query_value.split(', ').map { |h| (h1, h2) = h.split('=>'); { h1 => h2 } }.reduce(:merge)['query']
      end
    end
  end
end
