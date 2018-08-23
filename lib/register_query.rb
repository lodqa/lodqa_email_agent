# frozen_string_literal: true

received_mail = MailReceiver.receive_mail
received_mail.each do |mail|
  # LODQA BSにクエリーを登録するスクリプトを追加する
  LodqaClient.post_query mail[:body], mail[:email]
end
