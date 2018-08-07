# frozen_string_literal: true

# LODQA BSにクエリーを登録するスクリプトを追加する
class RegisterQuery
  def self.execute
    LodqaClient.post_query 'Which genes are associated with Endothelin receptor type B?'
  end
end

RegisterQuery.execute
