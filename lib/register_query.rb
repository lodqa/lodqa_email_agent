# frozen_string_literal: true

require "#{Rails.root}/lib/lodqa_client.rb"

# LODQA BSにクエリーを登録するスクリプトを追加する
LodqaClient.post_query 'Which genes are associated with Endothelin receptor type B?'
