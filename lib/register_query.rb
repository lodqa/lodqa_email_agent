# frozen_string_literal: true

# LODQA BSにクエリーを登録するスクリプトを追加する
LodqaClient.post_query 'Which genes are associated with Endothelin receptor type B?'
# メールを送信する
MailSender.send_mail('text mail', 'how are you?')
