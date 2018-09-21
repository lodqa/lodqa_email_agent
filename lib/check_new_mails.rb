# frozen_string_literal: true

require_relative 'mail_receiver.rb'

received_mails = MailReceiver.receive_mail
received_mails.each do |mail|
  # LODQA BSにクエリーを登録するスクリプトを追加する
  puts "POST query #{mail[:query]} to the LODQA_BS."
  LodqaClient.post_query mail[:query], mail[:reply_to], mail[:query_option]
end
