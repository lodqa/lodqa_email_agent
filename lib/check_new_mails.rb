# frozen_string_literal: true

received_mails = MailReceiver.receive_mail
received_mails.compact!
received_mails.each do |mail|
  # LODQA BSにクエリーを登録するスクリプトを追加する
  LodqaClient.post_query mail[:body], mail[:email]
end
